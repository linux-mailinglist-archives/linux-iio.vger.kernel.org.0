Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC6C916B031
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2020 20:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgBXTXe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Feb 2020 14:23:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27017 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725860AbgBXTXe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Feb 2020 14:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582572213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ucm63i8Qwmi7aPinQR/QfuojbFJEi+6ubQg7jtj81vs=;
        b=NH1hsHgNMegfnB6Qkvs13/zl0a0/ilCgxtb0h5KfiI/owR4W45jdv2p5OXh2XpgTz2ylb1
        2FL+cNuuo32DkP5FA6dP2HzBoV+mYAtIxlc9a4pIMSelUViWKhg2BixzlVyNEGSNKvoJ1T
        7zJWUU+Fz8E8EmS/0lXF73WY1osciv4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-tpyZU6apNfysedMTyhu50A-1; Mon, 24 Feb 2020 14:23:31 -0500
X-MC-Unique: tpyZU6apNfysedMTyhu50A-1
Received: by mail-wr1-f72.google.com with SMTP id n12so4154889wrp.19
        for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2020 11:23:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ucm63i8Qwmi7aPinQR/QfuojbFJEi+6ubQg7jtj81vs=;
        b=k8S7N7vDM8bHdS9/tcLPDxRq2ubGg8x+i4ohfSlpYXTx6vMypDjq7zIEKwRTJ58q+r
         yYpH5xkTQ54OXPcE3hB5MNMc7esmMX1ZSHqmZpkdlmmamx/CDyXO7OmjmPepdHm7Epw6
         vQNReomMtKpuCbWaIyw0tcHyJZluOrIinuw+fdFrk/NFZ28SEqLd6XYb+fi9flhhnQkz
         o0QEZGggb3UI9MbyWIqwbEtm8MkxdAvbFCITwk04C4uj7C/63X+TheJ5IJlQuUcKaYSz
         N/CJr+wWDWkkwCLoolT7+yqsPjBDzJRgcyhYIGTe5rtzLd+0WXkmCawq41ffPRMtmtLX
         igNA==
X-Gm-Message-State: APjAAAWV1ZYT68Ym7pwqOKnKlpj1IJKDQUaUtN6k58LqjKH3JrbtxeE6
        Qh5xK6FBOhwTyQj1pQa0pty3J7e4IVCNl1JifvPiRdmvkIHzimBAtO8G12/7bomzxttNaQm6zjD
        wyzL9ocaX0+//amF3+i7p
X-Received: by 2002:a5d:4705:: with SMTP id y5mr68677666wrq.370.1582572209722;
        Mon, 24 Feb 2020 11:23:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3DGTBw2Axqg8/IA9sE56xDTp9aMYq8ha0N03ppzhNAe0VZOA2y4+9tBYdnnKvqdcmqmjJCw==
X-Received: by 2002:a5d:4705:: with SMTP id y5mr68677646wrq.370.1582572209535;
        Mon, 24 Feb 2020 11:23:29 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id 25sm536267wmi.32.2020.02.24.11.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 11:23:28 -0800 (PST)
Subject: Re: [PATCH] iio: st_sensors: remap SMO8840 to LIS2DH12
To:     Wen-chien Jesse Sung <jesse.sung@canonical.com>,
        linux-iio@vger.kernel.org
References: <20200224095426.25681-1-jesse.sung@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a4f690f2-19a5-fc67-8072-eb14b8df0017@redhat.com>
Date:   Mon, 24 Feb 2020 20:23:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224095426.25681-1-jesse.sung@canonical.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 2/24/20 10:54 AM, Wen-chien Jesse Sung wrote:
> According to ST, the HID is for LIS2DH12.
> 
> Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>

I added the original "SMO8840" entry since I did not have any
docs I just copied the "SMO8A90" entry. Looking at the driver
the only difference seems to be that the LNG2DM only has 8 bits
accuracy where as the LIS2DH12 has 12 bits. I can confirm that
this patch works on my Lenovo Ideapad Miix 320, for which the
original patch was submitted, and that I indeed get 12 bits of
accuracy with this patch.

So this patch is:

Tested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>   drivers/iio/accel/st_accel_i2c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index 633955d764cc..849cf74153c4 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -110,7 +110,7 @@ MODULE_DEVICE_TABLE(of, st_accel_of_match);
>   
>   #ifdef CONFIG_ACPI
>   static const struct acpi_device_id st_accel_acpi_match[] = {
> -	{"SMO8840", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
> +	{"SMO8840", (kernel_ulong_t)LIS2DH12_ACCEL_DEV_NAME},
>   	{"SMO8A90", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
>   	{ },
>   };
> 

