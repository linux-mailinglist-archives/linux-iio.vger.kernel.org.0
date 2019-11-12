Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B1DF8B73
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2019 10:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKLJNO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Nov 2019 04:13:14 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:52818 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbfKLJNO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Nov 2019 04:13:14 -0500
X-Greylist: delayed 1634 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Nov 2019 04:13:12 EST
Received: from [109.168.11.45] (port=49434 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1iURoC-001OEo-QE; Tue, 12 Nov 2019 09:45:56 +0100
Subject: Re: [PATCH v2] i2c: use void pointers for supplying data for reads
 and writes
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20191112005826.GA96746@dtor-ws>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <f1bda5eb-b3ad-e7e1-f832-54a62e708d9c@lucaceresoli.net>
Date:   Tue, 12 Nov 2019 09:45:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112005826.GA96746@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Dmitry,

On 12/11/19 01:58, Dmitry Torokhov wrote:
> There is no need to force users of i2c_master_send()/i2c_master_recv()
> and other i2c read/write bulk data API to cast everything into u8
> pointers.  While everything can be considered byte stream, the drivers
> are usually work with more structured data.
> 
> Let's switch the APIs to accept [const] void pointers to cut amount of
> casting needed.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I agree on the principle, but I have a question, see below.

[...]
>  s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
> -					      u8 command, u8 length, u8 *values)
> +					      u8 command, u8 length, void *values)
>  {
>  	u8 i = 0;
>  	int status;
> @@ -647,8 +648,7 @@ s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
>  			status = i2c_smbus_read_word_data(client, command + i);
>  			if (status < 0)
>  				return status;
> -			values[i] = status & 0xff;
> -			values[i + 1] = status >> 8;
> +			put_unaligned_le16(status, values + i);

The switch to put_unaligned_le16() looks unrelated, is it?

>  			i += 2;
>  		}
>  	}
> @@ -657,7 +657,7 @@ s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
>  		status = i2c_smbus_read_byte_data(client, command + i);
>  		if (status < 0)
>  			return status;
> -		values[i] = status;
> +		*(u8 *)(values + i) = status;

My preference is to use an u8* helper variable in these cases:

s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client
*client,
-			      u8 command, u8 length, u8 *values)
+			      u8 command, u8 length, void *buf)
 {
+	u8 *bytes = buf;
@@
-		values[i] = status;
+		bytes[i] = status;

This clarifies we are accessing the raw bytes, avoids typecasts in the
middle of code for readability and avoids void pointer math.

PS: look, it's exactly what you do in the max1363.c file below! :)

> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 5c2cc61b666e7..48ed76a0e83d4 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -182,9 +182,9 @@ struct max1363_state {
>  	struct regulator		*vref;
>  	u32				vref_uv;
>  	int				(*send)(const struct i2c_client *client,
> -						const char *buf, int count);
> +						const void *buf, int count);
>  	int				(*recv)(const struct i2c_client *client,
> -						char *buf, int count);
> +						void *buf, int count);
>  };
>  
>  #define MAX1363_MODE_SINGLE(_num, _mask) {				\
> @@ -310,27 +310,29 @@ static const struct max1363_mode
>  	return NULL;
>  }
>  
> -static int max1363_smbus_send(const struct i2c_client *client, const char *buf,
> +static int max1363_smbus_send(const struct i2c_client *client, const void *buf,
>  		int count)
>  {
> +	const u8 *data = buf;

Here it is! ^

-- 
Luca
