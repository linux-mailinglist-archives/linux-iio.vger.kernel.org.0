Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2CB2568DF
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 17:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgH2P5u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 11:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728310AbgH2P5l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 11:57:41 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FDB220CC7;
        Sat, 29 Aug 2020 15:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598716661;
        bh=YHcSw/hqKHXdDTuCSO/5dUdyJsCtyVzZTzxsaX4IgQ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AkdJQsqeMBVFlI4TSshlD/nSJrK5ARHEAUHmsDHccDh8eYv3qeyks8P0oSmoUP1JF
         /iMp71OeOFuKi9TvL5EkWjLwmy/PieLf1t36ev8C2wbtY+MRYbbYCwZ2065fej+fR3
         VcDQp+02Yv7vLoOzgcYh7Rd3umJh2zYrAwUQtTBc=
Received: by mail-ed1-f51.google.com with SMTP id q4so1766357eds.3;
        Sat, 29 Aug 2020 08:57:41 -0700 (PDT)
X-Gm-Message-State: AOAM533X3b+rBCm3X1gdI75cDONhEabyGt/OVq6nKibSUyY/1Zu4uivV
        WxevJS99DFvzDyYQGBiw6lHCINmcnnKeK5eOyoo=
X-Google-Smtp-Source: ABdhPJx/hw+xUReRY08qMnVSvo8WfizFrkcGJBp6fVnLKoNLq4zUQsZf+SAHKYqnu6aW9Akvgdww2mqhRltNtho15Ik=
X-Received: by 2002:a05:6402:515:: with SMTP id m21mr1264650edv.348.1598716659667;
 Sat, 29 Aug 2020 08:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200826161539.20788-1-krzk@kernel.org> <20200829162102.602a3424@archlinux>
In-Reply-To: <20200829162102.602a3424@archlinux>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sat, 29 Aug 2020 17:57:28 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfOBR16_UjW5-Xv+9n4OFuOL9Aykzm2zqjx+G3KYHEkGA@mail.gmail.com>
Message-ID: <CAJKOXPfOBR16_UjW5-Xv+9n4OFuOL9Aykzm2zqjx+G3KYHEkGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: magnetometer: mag3110: Simplify with dev_err_probe()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 29 Aug 2020 at 17:21, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 26 Aug 2020 18:15:38 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> > Common pattern of handling deferred probe can be simplified with
> > dev_err_probe().  Less code and also it prints the error value.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> I'm a lazy person, so if you have a series like this where you decide
> to post a new version without anyone having commented on it, please
> send a quick reply to say you have done that.  Avoids me
> applying wrong versions of things!

It was the part of v3 (18 patches) which you just applied so these two
you can skip.

Sorry for not mentioning it.

Best regards,
Krzysztof
