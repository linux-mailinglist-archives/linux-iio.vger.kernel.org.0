Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200606836CD
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 20:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjAaTs5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 14:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjAaTsy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 14:48:54 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111E8166C1
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 11:48:52 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bk15so44866316ejb.9
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 11:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cN+1sFmTFjHDf7odFjUo1GhN8ICBPenNPF+TaZ5djao=;
        b=itz/kyA0bEv6FSOYCzD+gLAD3eiuGzV1RWt+sisgmpCthNpHywJ3tBWDht7blgdwJu
         eOhnBMRDhmstP4TUdtaYUeKap88S5h6zWLpjzdsf3hiLShNlWYB43mQOQqCaqfrUZB0L
         q9ZqD0Kh/RO0iJDbfxZHmlLkTnzGpScgpoyx1AEwfj2iJ4DhtEGjAaauj7lW6K78Ex52
         +jJUc8lEqtRM6KQtEZAxNweg2wn1+loid8MOFYzOM0n67Ce1qfBRdKEj+Loj3THKbuE0
         7mRSOJh9fs8bg5l2o/OTweTGyTiC3+LC6Gx5gr2jZs7kDtL/dJkUV2UNPPDkmwsyHmKa
         le9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cN+1sFmTFjHDf7odFjUo1GhN8ICBPenNPF+TaZ5djao=;
        b=OWKH30WMSzfbMu6Dzt9Oq17eZBLkSFaJeYNpygcuFPpPQKRn1U/s6IU9toEwhRlgBs
         JNoz5UDRWcIcStMi0s3PXDmXyRuxm4i5sLnHr2e+c8QWnoy3zaGwZJ5IyXzwPjWgl+SH
         dmBufF8RWHjCjy5PRDBeMDAyAd96kq42pC8okHOKQ4/uMoN5sQ65NEQjlksJ1K4qf5nj
         rZxYF7MIH3VPHTZCRAUdK/pz54tY+y64MITcDjXlbaaNLSqTB1MC5ebzoOyEQg6RM76F
         twVKQyNxP2NFG7W3XrO5Q8m+MqkWxZaSGlA08AaaZU5CNQ3RHgMYo7KlZ+uFqhcGM3Wi
         7tAg==
X-Gm-Message-State: AO0yUKViTcIxpjNqr0KLJ3wH1Ga2F5EXSIICWnXw9nD+yHItdIW5utcl
        gxwz08OB1GqtZ9TgPN6zeAg=
X-Google-Smtp-Source: AK7set96BEvvHbXDV9u0kEgeUCUNFNdYRWVcIBAYhw1iGZV47DkakIh1LoDdQTfilA4r6i27RHYCLA==
X-Received: by 2002:a17:906:590a:b0:87b:d625:544c with SMTP id h10-20020a170906590a00b0087bd625544cmr18121872ejq.49.1675194530653;
        Tue, 31 Jan 2023 11:48:50 -0800 (PST)
Received: from carbian ([2a02:8109:aa3f:ead8::c406])
        by smtp.gmail.com with ESMTPSA id t13-20020a50d70d000000b00458b41d9460sm8886514edi.92.2023.01.31.11.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 11:48:50 -0800 (PST)
Date:   Tue, 31 Jan 2023 20:48:48 +0100
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: accel: kionix-kx022a: Minor fixes
Message-ID: <Y9lwoMIPD134k0dy@carbian>
References: <cover.1674996464.git.mehdi.djait.k@gmail.com>
 <d6e797c3-ef06-c89f-e181-45535d23f614@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6e797c3-ef06-c89f-e181-45535d23f614@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Matti,

On Mon, Jan 30, 2023 at 10:15:51AM +0200, Matti Vaittinen wrote:
> Hi Mehdi,
> 
> On 1/29/23 15:37, Mehdi Djait wrote:
> > Two minor fixes. Swap the setting of rd_table and wr_table and remove
> > the g_range member.
> > 
> > Matti, I thought about defining an unsigned int array for the 4 possible
> > g ranges, setting a g_range initial value in the probe function and
> > updating it in the write_raw callback (case IIO_CHAN_INFO_SCALE)
> 
> How would it differ from current write_raw behaviour (below)?
> 
> [mvaittin@dc75zzyyyyyyyyyyyyycy-3 linux]$ grep -A70 write_raw
> drivers/iio/accel/kionix-kx022a.c
> static int kx022a_write_raw(struct iio_dev *idev,
> 			    struct iio_chan_spec const *chan,
> 			    int val, int val2, long mask)
> {
> 	struct kx022a_data *data = iio_priv(idev);
> 	int ret, n;
> 
> 	/*
> 	 * We should not allow changing scale or frequency when FIFO is running
> 	 * as it will mess the timestamp/scale for samples existing in the
> 	 * buffer. If this turns out to be an issue we can later change logic
> 	 * to internally flush the fifo before reconfiguring so the samples in
> 	 * fifo keep matching the freq/scale settings. (Such setup could cause
> 	 * issues if users trust the watermark to be reached within known
> 	 * time-limit).
> 	 */
> 	ret = iio_device_claim_direct_mode(idev);
> 	if (ret)
> 		return ret;
> 
> 	switch (mask) {
> 
> //snip
> 
> 	case IIO_CHAN_INFO_SCALE:
> 		n = ARRAY_SIZE(kx022a_scale_table);
> 
> 		while (n-- > 0)
> 			if (val == kx022a_scale_table[n][0] &&
> 			    val2 == kx022a_scale_table[n][1])
> 				break;
> 		if (n < 0) {
> 			ret = -EINVAL;
> 			goto unlock_out;
> 		}
> 
> 		ret = kx022a_turn_off_lock(data);
> 		if (ret)
> 			break;
> 
> 		ret = regmap_update_bits(data->regmap, KX022A_REG_CNTL,
> 					 KX022A_MASK_GSEL,
> 					 n << KX022A_GSEL_SHIFT);

        /*
        * The only difference would be to store the g_range value in the
        * driver private struct when the user changes it from sysfs
        * (in this case I defined an array called kx022a_g_range_table)
        */

        data->g_range = kx022a_g_range_table[n];

> 		kx022a_turn_on_unlock(data);
> 		break;
> //snip
> 
> 
>  but
> > does it make sense to keep track of the g_range value ?
> 
> Do you mean caching the g_range instead of retrieving it from the hardware?
> I don't know an use-case where reading the range would be time-critical -
> and even if it was, the regmap should cache the value anyways. (unless
> KX022A_REG_CNTL is in volatile range). So no, I don't think caching the
> g_range is worth it.
> 
> Yours,
> 	-- Matti
> 
> -- 
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
> 
> ~~ When things go utterly wrong vim users can always type :help! ~~
> 

--
Best Regards,
Mehdi Djait
