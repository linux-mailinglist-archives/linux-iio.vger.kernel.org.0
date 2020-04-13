Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B921A6F0C
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 00:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389542AbgDMWX6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 18:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389528AbgDMWX6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 18:23:58 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23D9C0A3BE2
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2020 15:23:57 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n17so10398517lji.8
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2020 15:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hOJzEh+GtDvN9Quiqz6IX5/33GKsh67OKgylNu6oVIU=;
        b=GSxlT1fz6RQ87Z8QMQPuW8bYXM2ScxY1cFoe5ov8QJ/yYlctp19DIFLKilFAdXYtDS
         pSX1D7ps3VEk6L6AwFWhJvnVNolNXaMdi2I5mKj7/mNmTzOFEFjn1EjBZk5oC60NC7mn
         xqSLEvoIgAlVQkcYLIgdca7bfDdO6fXHmRJvd+gqjHNeOY6GBtqm4hKxIMFfWIXFQb1I
         j2nG+SOVaLE+mIv75JJyQ6ohOHa+pmlNddcSFx7IVjYqDZfz5YB3k7nnIhfwFyVLMsem
         mgxOb1NCjUbT4T6u9dt5R/9MlTJyReBtvmp2+gbc1JD0tcVfLsEu9eyEQNbSfcx4PnZ5
         9o/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hOJzEh+GtDvN9Quiqz6IX5/33GKsh67OKgylNu6oVIU=;
        b=O4JCDXVKtOX24dBd4YbXUKOB6JnPVmm6s8pRDIctvFSlS4TjkOVQFShKao2UM+zMZI
         Rp2G5R3twzxc1ZTJvzBS+aehnGzBJj/8BWXC/kiZCayJGzNx8xmsAMTQzJOqeicSDC9U
         8koxdqWfS7tr1bTJcjlSFNZxniX4RpsKEbMKRfbR74LbJ4o91gaoILkQ3gewk+WB/svP
         67U1Dm0uuznKYEaRapgouKLBHrfOWBrLEhdgcxKPt+TaPHh5f0PsFV1Yo4tXFVUwo1w7
         47ISxfpTxiZrAlcrJrW3GW8snTlE13F3Et5ix8jhdqtlKXE28z8ttQvd0r9Ssn7hysPl
         Hwlw==
X-Gm-Message-State: AGi0PuZfC9S8zJqUkPlJHP5nsVNrLJd4aYCJDZvMHDkwickT4s/iOf90
        GdAAcIX1/l60u0xhMC9j5CHtbi6vki9W4bXeeGXocw==
X-Google-Smtp-Source: APiQypJz+NAbVKX1pvYlsMZklUbdsi8OVkfeMAfqQRqrJPtqUMiMm6LXTq82c7V5JR2PrcGD/+niR792VziZLvdmn24=
X-Received: by 2002:a2e:5048:: with SMTP id v8mr10655018ljd.99.1586816636200;
 Mon, 13 Apr 2020 15:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200406141350.162036-1-nick.reitemeyer@web.de> <20200406141350.162036-2-nick.reitemeyer@web.de>
In-Reply-To: <20200406141350.162036-2-nick.reitemeyer@web.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Apr 2020 00:23:45 +0200
Message-ID: <CACRpkdZDmYGcz11nqt++18NCD6G7S99S=qL9fXK0JLuqDWAuVA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: magnetometer: ak8974: Add Alps hscdtd008a
To:     Nick Reitemeyer <nick.reitemeyer@web.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 6, 2020 at 4:23 PM Nick Reitemeyer <nick.reitemeyer@web.de> wrote:

> Add binding documentation for the Alps HSCDTD008A, which is similar
> to the ak8974.
>
> Signed-off-by: Nick Reitemeyer <nick.reitemeyer@web.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
