Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F67A1C70C1
	for <lists+linux-iio@lfdr.de>; Wed,  6 May 2020 14:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgEFMtP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 May 2020 08:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728374AbgEFMtP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 May 2020 08:49:15 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1905C061A41
        for <linux-iio@vger.kernel.org>; Wed,  6 May 2020 05:49:13 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u6so2206285ljl.6
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2020 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=96KaXeAdxDN7S+27ovqYy5Q1Gxi7lCFPE6ZMVCl7BqI=;
        b=XShFsqLyplry1L66Zl8shbZPee8zXMCvlxoM7IkG1FzFQ3hPub4i8SNAgGCpmm6PNY
         YjJ+mIQyLOXDlvML5V0GFIz+o1dyZKBI8PkTFCqF7AFrTHmUoIf/bqTubfdbXqPuoU7Z
         T4/Td7CrjFOCqoCOZj1jZUS/y4sbVIfUM2P4hal5UoenYCIUfkUjhVvSxxiK+y1ReG5G
         3wJEDnQQy4WhZHjSuldD/Hen21HlzKR+/BwTLit6vSKdvXwJZYdud4UOZBKnMu+EDQHx
         ozQ+1w50lCl2HU223fSSsDIT9Df9y6xRBRcGxDEi9b93sljfYrisRuLKsBtWbyutmIbL
         +oQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96KaXeAdxDN7S+27ovqYy5Q1Gxi7lCFPE6ZMVCl7BqI=;
        b=lJsVXX95wlCQOCrJaQjLODFp+UqLUVU0irSE8I6jxUJ+kzTcFC6tAoB9N6ZhOAYT56
         z1L61Cwgujr3L/MxwVruRTdqKqllwotz3GnLkDJhdNubaQQnmEKaBKCjvs5HDarJs9ps
         O2GA5HXkALAUmaclWSeWy2lL9NrMZsotMmKMsXHUpbTKFV1iNFmhDVd8jKTzlsSVf7kg
         ycbgpEMxQpWMDtfjn5tH6yqwUUfFdEUcYYsQFrWNKVbKeRwv3SeCj3ay9EbxtT5p8P5k
         UGtLbOW9TvEsNvWGTYlMRbjT58DI4nhTPWyXyxbW3b9w0Pl/NUhwapuOKekws5GWq9Tf
         ry3A==
X-Gm-Message-State: AGi0PubypHtJhoeJ8x+D/BDBX8Uw8JS5KbK6+Qy6+1vHOG5S777uVPTH
        IqzOuPiJyWhCGRi7jmJY0cr3FHy8MIHXRKCqkaaTlg==
X-Google-Smtp-Source: APiQypIAyC6SBzHiCf7KEpdPSxq7XIL/sTxURCMc4sLRWiat+uT9NDQsN6LvZJJH7Ri2pTRFUwI+ZZApG8SocpWjcsE=
X-Received: by 2002:a2e:2ac2:: with SMTP id q185mr4721006ljq.125.1588769352183;
 Wed, 06 May 2020 05:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200503172206.13782-1-xc-racer2@live.ca> <BN6PR04MB0660DA2A47787A56A2FC7290A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
In-Reply-To: <BN6PR04MB0660DA2A47787A56A2FC7290A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 May 2020 14:49:00 +0200
Message-ID: <CACRpkdYxT0qrAuaFsmEOgZXF8Sj2wRn-PAjJp_RpY=3QVEwT5w@mail.gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: iio: accel: Add bma023 compatible to bma180
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

> The bma023 is in the same family as the bma180 and support is
> being added to the bma180 IIO driver for it.
>
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
(...)
>    - compatible : should be one of:
> +    "bosch,bma023"

Please add bma150 and smb380 compatibles at the
same time, it's simple enough and nobody will get hurt.

With that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
