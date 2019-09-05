Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9D3BA9776
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2019 02:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbfIEACd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Sep 2019 20:02:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40319 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfIEACd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Sep 2019 20:02:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so468673pfb.7
        for <linux-iio@vger.kernel.org>; Wed, 04 Sep 2019 17:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=DMDiIQY2gVxor/9tfnSEdI8BwtB46XK7pBIB2yMTLBc=;
        b=o+xsl4lmBHGpnDImWPM+EZHQW8VVGoHi4Ms8RXruJR+FJ/vQ2e61uWD0J7ERaS4FKZ
         +LAbashurqA9qoUt55zN6vY+z7XjB8j669RaxOBPkjDMFkhUw5Poq2OE6Eoqg3rZlcOh
         67ctW4j73di+6QPuk1BgvRwvdlGOu6oA8PbE25+4TAGv2lc9R2PHjI8jYFUiPz7MEAUV
         OKa+0uv2hM12FZCfoKnuFYzUIetiBzEE+AzlYURObnb1YYQdc9k9Yy8Detsp39urQD/p
         DPPx4eT88OOb8OUMhLUvN1ABBLq3fIbijVX0O+hVzuABVav6duYiI/e8gcjoJmLsJWMr
         /pBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DMDiIQY2gVxor/9tfnSEdI8BwtB46XK7pBIB2yMTLBc=;
        b=Qx0M37Qp8dUPhOUAfGwuvPgDdPOChHXWso/7J11wPbj6kUN/Q6fd4tho+da+Xgomp+
         R8wwnj8fxpqidezwLgT4J6rOH8Ax7/z6oDHREzVwpysSy5PywWy3hy6NiGWIYga3kI0T
         STtrn2u0Hm2FElNYxSZeHIDLNwXIVNnBO25rJZV7MmBEbtC/LOAfrcM0ri04ex9d4Zy+
         lcyd7pbb+LX1YC/mQU5jSnKozWx0/u4cso0yjjj2GwGSHDxJg4pA1a1ufUbWAUeBTT2J
         NvYzOcRuwdJbXEcYQEDi+/cn6joK330yJ/57zHQcrEaJ48yRZCbhxt0TxSZx7X+x+Udd
         ROXw==
X-Gm-Message-State: APjAAAWLm7Ytrjzy03KxSbWOycGvuYvXUSoRROKrPUDn37v2KlHLdQf5
        2KjVoEpGwv/w9zrjXbz+Fh5b5g==
X-Google-Smtp-Source: APXvYqzc0wRcdryTLKgsgoGOwLmF9g/litQYYjhoz0VIQFDDUflUHMSdrzjEFyAFp2XzF5NH1fDC5A==
X-Received: by 2002:a63:553:: with SMTP id 80mr665691pgf.280.1567641752363;
        Wed, 04 Sep 2019 17:02:32 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id g24sm192291pfo.178.2019.09.04.17.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 17:02:31 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Remi Pommarel <repk@triplefau.lt>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Remi Pommarel <repk@triplefau.lt>,
        Elie Roudninski <xademax@gmail.com>
Subject: Re: [PATCH] iio: adc: meson_saradc: Fix memory allocation order
In-Reply-To: <20190901105410.23567-1-repk@triplefau.lt>
References: <20190901105410.23567-1-repk@triplefau.lt>
Date:   Wed, 04 Sep 2019 17:02:30 -0700
Message-ID: <7h8sr3txt5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remi Pommarel <repk@triplefau.lt> writes:

> meson_saradc's irq handler uses priv->regmap so make sure that it is
> allocated before the irq get enabled.
>
> This also fixes crash when CONFIG_DEBUG_SHIRQ is enabled, as device
> managed resources are freed in the inverted order they had been
> allocated, priv->regmap was freed before the spurious fake irq that
> CONFIG_DEBUG_SHIRQ adds called the handler.
>
> Reported-by: Elie Roudninski <xademax@gmail.com>
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
