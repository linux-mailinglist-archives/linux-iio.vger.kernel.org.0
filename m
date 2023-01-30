Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA21680735
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 09:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbjA3IQW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 03:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbjA3IQM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 03:16:12 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0502B63A
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 00:15:54 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id me3so29325488ejb.7
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 00:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pl3+FRFZ7zaIRqqDz3jMsO+NVs9ARq1ce75QsDrwN+s=;
        b=hWhG+0tiHCKyFlzvM0YjMnb5JJTVCYmua0VcwKfo6nJiGWxTISGSGeYSdpj/eqiFVb
         X9a2q/vd97oCDgmYNrvykkTMQLFL4zO4mjSijAT/LEDP44gOz2zuk/rju3nKFWS5VHIb
         ZZtMzLs6Ind4vYdPOKSMcpq977WkQP2OpIrzAYaw8nzRpg83DvwoWj4zGoWdUgLl0bGa
         DI0hVQOvJNfBff+9gs8hvypx3cw9/yQY7T+3SwswpdRvaUMIa+hxuo79M16bPSGkMq38
         zu0lZ1pQrFz1AxHXtPA9tsfKGoGMfYxABtgeyf7QW5QeaTYpVTJYkgWUNhsltxHLeW0o
         5C/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pl3+FRFZ7zaIRqqDz3jMsO+NVs9ARq1ce75QsDrwN+s=;
        b=nMYamJfUXYW/RJI6AGY2A2Imr1yIfJb+de37DxXR4ICLqVivy2swVRW5N655pzjVKB
         r2tRpDmfRtIn1aipj+rMJf3biki2I2az5dq8dx/bw6MKpl/ajCpg6wxH4egdEcwGZn0K
         HvflJeYs68lkLG9SYJ8239kUs6hiihtWEf3eadK9y172TDoXV2s8EOxSi0lNVqhs3c98
         QB6VSBKZHKcjGIg78b8/FjXX3nzSmHRt83ncz3WS2ZSyaPfYm97VPXC4+IU4NtiebNY0
         4URrUVc2PDKvnxiue93ZiR51CDCseYI4anV+SwEzsVwvxZ2XUsFLxmqX7VJoFV5om9OR
         Jxvg==
X-Gm-Message-State: AFqh2krTTAbPNUFxBjqEjxfXFMQNoQM2m/mXnpqC+UU7kZoKDCD+X0Nd
        oIK144S/om4KvQOUvYpbKqKkGtKkODU=
X-Google-Smtp-Source: AMrXdXvj1Cq2FxgH9jlWNqhmA70x7BXHyn8aZ39hlbQofST1lWEQdErn9/B4xhQoT8ycQDSzSewGlg==
X-Received: by 2002:a17:907:6f18:b0:84d:4e4f:1f85 with SMTP id sy24-20020a1709076f1800b0084d4e4f1f85mr50423726ejc.59.1675066552564;
        Mon, 30 Jan 2023 00:15:52 -0800 (PST)
Received: from [172.16.196.130] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id v17-20020a1709067d9100b00887ce5caf66sm1715420ejo.59.2023.01.30.00.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 00:15:52 -0800 (PST)
Message-ID: <d6e797c3-ef06-c89f-e181-45535d23f614@gmail.com>
Date:   Mon, 30 Jan 2023 10:15:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org
References: <cover.1674996464.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 0/2] iio: accel: kionix-kx022a: Minor fixes
In-Reply-To: <cover.1674996464.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Mehdi,

On 1/29/23 15:37, Mehdi Djait wrote:
> Two minor fixes. Swap the setting of rd_table and wr_table and remove
> the g_range member.
> 
> Matti, I thought about defining an unsigned int array for the 4 possible
> g ranges, setting a g_range initial value in the probe function and
> updating it in the write_raw callback (case IIO_CHAN_INFO_SCALE)

How would it differ from current write_raw behaviour (below)?

[mvaittin@dc75zzyyyyyyyyyyyyycy-3 linux]$ grep -A70 write_raw 
drivers/iio/accel/kionix-kx022a.c
static int kx022a_write_raw(struct iio_dev *idev,
			    struct iio_chan_spec const *chan,
			    int val, int val2, long mask)
{
	struct kx022a_data *data = iio_priv(idev);
	int ret, n;

	/*
	 * We should not allow changing scale or frequency when FIFO is running
	 * as it will mess the timestamp/scale for samples existing in the
	 * buffer. If this turns out to be an issue we can later change logic
	 * to internally flush the fifo before reconfiguring so the samples in
	 * fifo keep matching the freq/scale settings. (Such setup could cause
	 * issues if users trust the watermark to be reached within known
	 * time-limit).
	 */
	ret = iio_device_claim_direct_mode(idev);
	if (ret)
		return ret;

	switch (mask) {

//snip

	case IIO_CHAN_INFO_SCALE:
		n = ARRAY_SIZE(kx022a_scale_table);

		while (n-- > 0)
			if (val == kx022a_scale_table[n][0] &&
			    val2 == kx022a_scale_table[n][1])
				break;
		if (n < 0) {
			ret = -EINVAL;
			goto unlock_out;
		}

		ret = kx022a_turn_off_lock(data);
		if (ret)
			break;

		ret = regmap_update_bits(data->regmap, KX022A_REG_CNTL,
					 KX022A_MASK_GSEL,
					 n << KX022A_GSEL_SHIFT);
		kx022a_turn_on_unlock(data);
		break;
//snip


  but
> does it make sense to keep track of the g_range value ?

Do you mean caching the g_range instead of retrieving it from the 
hardware? I don't know an use-case where reading the range would be 
time-critical - and even if it was, the regmap should cache the value 
anyways. (unless KX022A_REG_CNTL is in volatile range). So no, I don't 
think caching the g_range is worth it.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

