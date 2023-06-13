Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7915872DB7D
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jun 2023 09:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbjFMHuG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jun 2023 03:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240476AbjFMHtt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jun 2023 03:49:49 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF3A10C6
        for <linux-iio@vger.kernel.org>; Tue, 13 Jun 2023 00:49:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f8cc042ea9so2347185e9.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Jun 2023 00:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686642584; x=1689234584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58s5A9sowol2exi73O8Wi+HEkQX9ngwelWfgjzw3I84=;
        b=GfoE6TGQW4CcDcKp5F7OcbLo/ettiTVMWhOLlTEzaVn4cCxdu4kooWKvmQgXJENHh5
         UN8R3AEsu06wuN+Tq14lFWAA6bngfiLrre8aDuk9wH3m7BKyOfJK9aXuyXrxPam0SnHv
         PT+z534B6EQPyh+Y9zwo+r3GWxHDMYpkXrztdz8mcac1qCYHwIWkUMTVS2qu7bML+ysl
         EFCMCchxkufqbnmZimtRgdGyKqB+HIDq/mcmjDER19f0l9g1W47+GLaTuMWM1Quhe3A+
         TurXlI7ocD1Ywg8i/Ij0eKAbLRj/IENoIzLP3lm1BPN8st2bxrH5aSU7dxRgNwypdwwO
         giog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686642584; x=1689234584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58s5A9sowol2exi73O8Wi+HEkQX9ngwelWfgjzw3I84=;
        b=Chp5kHK9P4Ca42xw/v04yu5b28Lsmxf2MPGrvBMjwoUwEYO7ZcVsjz7jvcFP05SXzA
         aM2EWTyJuobD+n9VJzumAOZkrrCGDdBf1nOQ9t53NgvZjlkPfihEm6UNgtYiPijEqqFB
         22E7oDlEfPf9efpy0NIVkA5uWXDxcUftIOeNFktTmvsjBtIHaiSJz+/s8DvS4Kd3UrbX
         x6gOskTvNhLBFSgCaA+l0pZlw59+GZHddljfw0Q03ML02rN0hT39uxI56liTl1JAB53T
         bUxANBH+/2LjVWVxXJ9YL9jF+IaTHNO46G7dL31KuZURuPw/Lq011USATyv8Hlc+WakJ
         HaOA==
X-Gm-Message-State: AC+VfDxsAzV3otoSVeWodN4bT2mA7BqHnHeyZyAv/Udr5gwiZTCh85Jb
        J0alZ5LrJBVAA1/iQYCm+d4=
X-Google-Smtp-Source: ACHHUZ4Rf/GVg0G5MX8J7tROvdzZevRDmPrFmOSGGWPG41A89vJH5LsEX/XKsTDNY3oPsL/RcJKXpQ==
X-Received: by 2002:a7b:cd19:0:b0:3f7:536e:fff3 with SMTP id f25-20020a7bcd19000000b003f7536efff3mr7492909wmj.25.1686642583954;
        Tue, 13 Jun 2023 00:49:43 -0700 (PDT)
Received: from user-PC.. ([92.51.95.194])
        by smtp.gmail.com with ESMTPSA id t25-20020a1c7719000000b003f7eeec829asm13535500wmi.10.2023.06.13.00.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 00:49:43 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     andy.shevchenko@gmail.com
Cc:     bigunclemax@gmail.com, linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH v3 1/3] iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC
Date:   Tue, 13 Jun 2023 10:49:19 +0300
Message-Id: <20230613074919.3936702-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZHzjpydKLQ7U_Qwf@surfacebook>
References: <ZHzjpydKLQ7U_Qwf@surfacebook>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi, Andre

>> +	}
>> +
>> +	if (num_channels > SUN20I_GPADC_MAX_CHANNELS) {
>> +		dev_err(dev, "num of channel children out of range");
>> +		return -EINVAL;
>
>Jonathan, but num_channels comes from the device tree. Why do we need to
>validate the upper limit and not simply use as much as we can?
>
>That's why I think this is not a critical error.

Looks like I missed this. So, if we rely on dtbs_check then I agree that
this check is not needed.

