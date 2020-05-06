Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8184E1C70CB
	for <lists+linux-iio@lfdr.de>; Wed,  6 May 2020 14:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgEFMtu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 May 2020 08:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728081AbgEFMtu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 May 2020 08:49:50 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39ACC061A10
        for <linux-iio@vger.kernel.org>; Wed,  6 May 2020 05:49:49 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id j3so2190338ljg.8
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2020 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGrAL221U5LNFhyomdWD44/6fcd1PnVHrarNM3q/rB4=;
        b=HKgt/yucHxP3oL+g7rj+nOg7Qg8kMDg6w4PXkk9Qk5J32RYqKhXSzTfL2UusXRkZ9r
         O2StDPBYRDXKb+J1PtGUc24f0sARXZnS89BtEMms1cXY+5flaKRfapQ9K7V3s03lll89
         codd1AN2XQZhUsdeXdFmiRNpoBYDAUcyiS0479s0pfBTTnLJwWpyBLJj5SZ+mIJ9zFCj
         PEtcVypA6N3FwlvTcob+epUPeNM+uiS+Cnl3BN1CpVJGlbKygZgVmT8OMBCL1Aos2QIv
         4/mPn1QV6hB/SLg2g4Q0UmozH8hGwGVOYINA418+STfObX11M7ZQPiR/e0tttmUtjlBR
         ddxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGrAL221U5LNFhyomdWD44/6fcd1PnVHrarNM3q/rB4=;
        b=QZ3B34nDfK4eC58317hlOunKk2xCJ+uDbMRDt8lad4fqokTLPa5ie0xYfBNL6SY8/y
         HeoFK2BdVAbu+cjd49034fsdI3fn8xKpFN3FOvDFMuYGEvm6SFMGPFchRFu9B3LPHaqK
         E+fp3W1TwayTwuYdd/aFvxiiHRTR5ch5wh39fchU8W/6EBIxsHp8XtTRYpYVliCRHPwO
         wagrvCsdBDngSOrmAKNaTLgj4TQrUMKoKhIOKBCnS4Ewswhp1z7i64yTAj5TipLosUJb
         rZJeseksRZJFqsX6htfp59PClbwwPq1vE/ReLmim/v2nABzjxWiRo4kwvFDkx+kgNOOR
         NC2A==
X-Gm-Message-State: AGi0PuZCTJmFDAkUaaXCJVEV8Li19dJEgBmXpj8ydkgxjw4xDCPeVHeU
        PRwVSouI9rsjh9nanb2DKYPeeuRZflJ9bgOeBuspvA==
X-Google-Smtp-Source: APiQypKsFo3w+1HtO8wBxx6yf4L26hGpogFQ0SkxurfXqdzs9iDJ62nzs6zcG/VDKtCJyrzv6laayACPUSjDv3/Lfjo=
X-Received: by 2002:a2e:8087:: with SMTP id i7mr4455713ljg.99.1588769387748;
 Wed, 06 May 2020 05:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200503172206.13782-1-xc-racer2@live.ca> <BN6PR04MB06609033B2E0AB157A228989A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
In-Reply-To: <BN6PR04MB06609033B2E0AB157A228989A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 May 2020 14:49:36 +0200
Message-ID: <CACRpkdY7aSe-MWdWvL-2NC0RKohpgibnod9dnNiS_Wr9eHL-_Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: iio: accel: Add required regulators to bma180
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 3, 2020 at 7:22 PM Jonathan Bakker <xc-racer2@live.ca> wrote:

> The bma180 and related chips should have two registers attached to
> them.  The IIO driver currently uses them, document them here as
> well.
>
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
