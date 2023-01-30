Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E13680691
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 08:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjA3HhS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 02:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjA3HhQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 02:37:16 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBD023640
        for <linux-iio@vger.kernel.org>; Sun, 29 Jan 2023 23:37:16 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qw12so13194461ejc.2
        for <linux-iio@vger.kernel.org>; Sun, 29 Jan 2023 23:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDeVAeYa5zUKrUApjfe3LuO2jcAOtLWcAY5Zt3F767w=;
        b=ZPwEn4KMTTTxBr74qwOJTGYNkxt/ZWV3s+gqVVdGZXN/9EiFnNP3oVlQODz3txDs6M
         nHs5SseGnnKLvzORV1YnovDqaythA9iok5Vv9yMp+GHYv4kDusGat5GOfEQYbeWcEDB0
         SMqEkP6NJPOWzDZOnUUcaNUDxL+aTY11gpwzvQHKI3f705MnzuvkObSnlvp6sErNV6Te
         49/uVo+noSiAbb9txforERRASIhpuJ1Rlv2W1jgazmP3B/Tlmfvqpja06b6CAMRV5DgL
         d/5SFReEwvJjkfBbDPydqR9uAiJ77/f4/tWYXNUrTipKeOaUQGEcqVyb7TxYa9FeDQYT
         ZmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDeVAeYa5zUKrUApjfe3LuO2jcAOtLWcAY5Zt3F767w=;
        b=2CIr87q6Y7lpF++Fgvjmjaajl4FuId0Z2tetGVQaO5eo4uKQ/D3OnIrNWYWgM6THdg
         mUX4EoS3hqpCGH0LunBEsrjw8CkCL6o9jfY9kWjkqEcAGwwIGconK3TMrqfVMwQ9d3Px
         qtTPlVN/O5rCa13AY0OFls9Jdxv0G5qRKGkNPNwZBa8yT+Dc8ac5R0/CfTf+WupQCwDS
         xVGVGcaTb1OC4Uq8xeFjFTB3yiEPkpRMUUZPJhL2/usWD2klYzLinEwC6Vz/HKNWfQrR
         isqKHMYpZfNG3wvWVubuIIh7A0dsrhusPoa6fPHHdOHewNvBRUlx6ux/z+JKNDWBc/K3
         T26A==
X-Gm-Message-State: AFqh2kq+JB9UzlojwR5j9ttGYQjQG/ZsPwthfTgPFVS/jNZ4C+iTkDMI
        /UmP/3q2fAHZz7tZPEqkH3zc6X9a390=
X-Google-Smtp-Source: AMrXdXvIKrc+Z7bBExfzMfX3vTciOOHT5xId3O5gAPcz2L0udqfs9VU3lm1Th9cLzYGIrwRt+V1RYg==
X-Received: by 2002:a17:906:9f03:b0:877:962f:be0a with SMTP id fy3-20020a1709069f0300b00877962fbe0amr34976022ejc.37.1675064234497;
        Sun, 29 Jan 2023 23:37:14 -0800 (PST)
Received: from [172.16.196.130] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q11-20020aa7d44b000000b0046ac460da13sm6396629edr.53.2023.01.29.23.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 23:37:13 -0800 (PST)
Message-ID: <ddbc6f91-44e3-4337-f957-a883d315d0a1@gmail.com>
Date:   Mon, 30 Jan 2023 09:37:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] iio: accel: kionix-kx022a: Fix the setting of
 regmap_config rd_table and wr_table
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org
References: <cover.1674996464.git.mehdi.djait.k@gmail.com>
 <0003ce97298da5afd9cfeab8ae8f93f50542fe8c.1674996464.git.mehdi.djait.k@gmail.com>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <0003ce97298da5afd9cfeab8ae8f93f50542fe8c.1674996464.git.mehdi.djait.k@gmail.com>
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

Thank you for the patch.

On 1/29/23 15:37, Mehdi Djait wrote:
> rd_table points to a regmap_access_table with valid ranges for read access
> and should be set to &kx022a_ro_regs which points to the read_only regs.
> The same for wr_table.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> ---
>   drivers/iio/accel/kionix-kx022a.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index f866859855cd..1d3af42ec0e1 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -142,8 +142,8 @@ const struct regmap_config kx022a_regmap = {
>   	.reg_bits = 8,
>   	.val_bits = 8,
>   	.volatile_table = &kx022a_volatile_regs,
> -	.rd_table = &kx022a_wo_regs,
> -	.wr_table = &kx022a_ro_regs,
> +	.rd_table = &kx022a_ro_regs,
> +	.wr_table = &kx022a_wo_regs,

Have you tested this? If I interpret the code correctly, the current 
code (before this patch) adds read-only registers - Eg, registers which 
are not writable - to wr_table no-range. I think it is correct way. Same 
for write-only registers - eg, registers which are not readable - are 
stored in rd-table no-range. Do you think I am misunderstanding something?

>   	.rd_noinc_table = &kx022a_nir_regs,
>   	.precious_table = &kx022a_precious_regs,
>   	.max_register = KX022A_MAX_REGISTER,

Best Regards
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

