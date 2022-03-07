Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3E34CF420
	for <lists+linux-iio@lfdr.de>; Mon,  7 Mar 2022 09:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiCGI5C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Mar 2022 03:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiCGI5B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Mar 2022 03:57:01 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC462019D;
        Mon,  7 Mar 2022 00:56:06 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u1so21996118wrg.11;
        Mon, 07 Mar 2022 00:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JAuL6YepBIXFjvPpdz3/zKExoKESbH/f50M7nxlrs1I=;
        b=nGao1OzYTY4jN+ZzN5oA5UmzE02b79yw/mCAIi5DnpU+5BC56C1OhsISLwcJ2FGV2X
         qFtfLM0IW/j+SMgI5cE6PFXVOKstMwjxmHov02cKZcsRbqeZEC0kmqp6Ra896qQr/CYg
         p6SLvoIumq63ElpdFWzCHXap6ABNysbFWJy1hhgTIVK2LIK3QJbFiKBOoHgDxnA/uBMM
         6zY1GA3KlafZax0xHREzDs5N4SMZCRepsKC2dDZaladCiJalofs90/aAp+WBvAiFcM/D
         u0ndNfHUlgtt67M4VK+r/OAl7yxGptV2hSsZG1UL3NfACqGC19Xu6nMVC3ZLWx3uxBeg
         WBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JAuL6YepBIXFjvPpdz3/zKExoKESbH/f50M7nxlrs1I=;
        b=1tw8FCvzi4K/YhDLbxkq/GC8wNqHXno8DhlmYmsbrtGb6OmTUUqYOH60bTu2Aqg5sN
         EwOnMIAyY5dq3pLLZ/Eyu7YC8GyxaWfn53T/BzAdOjUbNpMrWig+BAV2xKq5v/evi7fo
         wbMJD36OczJ2Smtwku1JHDIBEFCCXSE6zc7U/ThoOBBs9eftSHoLw0cdZFMcIgEUJToH
         3zmSoLKW804UQ9IZRbqERVpSiLqWduEsqWUoN2Fa2Rluo9gwrbS7wAAfZTd7qNmSuZnx
         nkInQV9RHUPxY3DwiZcuxG+HwIKaucDXgy/IJpXq4IugIc8/PhKKjdtkM68nqOYGS5u8
         dGfg==
X-Gm-Message-State: AOAM530ICkEEmIFD9U6apNk/fj695imLBeLxH8nQbM4qcaP87X7q0tpP
        7tJtJnIw1tvDTqoDTz/l2YKw5utvC6dcpDVo
X-Google-Smtp-Source: ABdhPJzPdzD3vG9myUxu4TceAdws6H8czXcxAxloDB5YBr/EYyckRyrzZIUUvQtTHFjqsl21N5t8EA==
X-Received: by 2002:a5d:452a:0:b0:1f0:48ce:97e0 with SMTP id j10-20020a5d452a000000b001f048ce97e0mr7375807wra.225.1646643364638;
        Mon, 07 Mar 2022 00:56:04 -0800 (PST)
Received: from tp440p.steeds.sam ([41.215.158.40])
        by smtp.gmail.com with ESMTPSA id j20-20020a5d6e54000000b001f0642807cfsm15052968wrz.117.2022.03.07.00.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:56:03 -0800 (PST)
Date:   Mon, 7 Mar 2022 10:55:56 +0200
From:   Sicelo <absicsz@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/3] Support LIS302DL in st_accel
Message-ID: <YiXInAKKwWRsWh40@tp440p.steeds.sam>
References: <20220301225432.60844-1-absicsz@gmail.com>
 <20220305155955.000075eb@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305155955.000075eb@Huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 05, 2022 at 03:59:55PM +0000, Jonathan Cameron wrote:
> Other the the issues Andy raised around the tag and also
> adding SPI support this looks good to me. 
> 
> We are very late in this cycle, so it is now material for 5.19.
> Plenty of time to make those final little tidy ups and get this
> queued early in the next cycle.
> 

Thank you so much. I will prepare next version of patches soon.

Sincerely
Sicelo
