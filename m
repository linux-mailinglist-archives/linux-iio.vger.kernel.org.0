Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC2E6B67DC
	for <lists+linux-iio@lfdr.de>; Sun, 12 Mar 2023 17:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCLQOi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Mar 2023 12:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCLQOg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Mar 2023 12:14:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4D6303C5;
        Sun, 12 Mar 2023 09:14:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE368B802C8;
        Sun, 12 Mar 2023 16:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B130C4339B;
        Sun, 12 Mar 2023 16:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678637672;
        bh=FCE5jgJ2s5ctABSahBVurGFndelAzrW/BC8pKEtLs3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PdO56aZ+xG7lauSvU0MhObVjWi3DDMad7b5C2DkslTdIZh8THQ+4a9QBBQY6gTw81
         fOYPKyRamJ6+hps0OdlVL9o4Oug9f5f75vwGvccIUfoitKLnvBqVZBMDVJMC4do3n5
         pRXfpqhvW45vucC1kRHwkwJn1QQqAPUA6tvLXGzM1u+zSjwSe1SpV9RbunmL5ETTx9
         hVdObFuTiFN2lrHtBO3/ZjMMfpQNiIQ3/fy/IXLXOibNtS99tUJKBYkM1hUOLEsDt1
         I1xRwTDPsh05ROKE3K1xLy58sCrYGAllUa0SH5/bWbvHJYHszweJYPwUKSksVTdgJV
         jmPPzi53xiAHg==
Date:   Sun, 12 Mar 2023 16:14:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrew Hepp <andrew.hepp@ahepp.dev>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v5 2/2] iio: temperature: Add MCP9600 thermocouple EMF
 converter
Message-ID: <20230312161438.304f5004@jic23-huawei>
In-Reply-To: <20230305213604.4747-3-andrew.hepp@ahepp.dev>
References: <20230305213604.4747-1-andrew.hepp@ahepp.dev>
        <20230305213604.4747-3-andrew.hepp@ahepp.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  5 Mar 2023 13:36:04 -0800
Andrew Hepp <andrew.hepp@ahepp.dev> wrote:

> Add support for the MCP9600 thermocouple EMF converter.
> 
> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
> Signed-off-by: Andrew Hepp <andrew.hepp@ahepp.dev>

Hi Andrew,

One minor improvement suggested inline.

If you can test with 
i2c_smbus_read_word_swapped() as suggested (I'm never sure when we need
the swapped form) that would be great.

If we had been later in the cycle I'd have taken this anyway and suggested
that change as a follow up patch, but we have lots of time, so no rush.

Thanks,

Jonathan

> +static int mcp9600_read(struct mcp9600_data *data,
> +			struct iio_chan_spec const *chan, int *val)
> +{
> +	__be16 buf;
> +	int ret;
> +
> +	mutex_lock(&data->read_lock);
> +	ret = i2c_smbus_read_i2c_block_data(data->client, chan->address, 2,
> +					    (u8 *)&buf);

Rare to see this call, so I went looking in the datasheet
https://www.kernel.org/doc/html/v5.5/i2c/smbus-protocol.html gives the structure
of this command as
S Addr Wr [A] Comm [A]
           S Addr Rd [A] [Data] A [Data] A ... A [Data] NA P

which matches the datasheet. However for two bytes it's also the same as...

S Addr Wr [A] Comm [A] S Addr Rd [A] [DataLow] A [DataHigh] NA P
which is the more common

i2c_smbus_read_word_data() which has a defined endian type and which
I think is the wrong one here.

Given that's a common situation we also have
i2c_smbus_read_word_swapped() which is same thing but for data the opposite
way around and will avoid the need for an explicit endian swap.

Jonathan



> +	mutex_unlock(&data->read_lock);
> +
> +	if (ret < 0)
> +		return ret;
> +	*val = be16_to_cpu(buf);
> +
> +	return 0;
> +}
> +
