Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB09DBEB5
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 09:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504655AbfJRHtE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 03:49:04 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45338 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504686AbfJRHtE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Oct 2019 03:49:04 -0400
Received: by mail-lf1-f65.google.com with SMTP id v8so3357858lfa.12
        for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2019 00:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GWv2DXhpUZsQEN5stqt6YqBuhWFLoKxaG6XaaNvgSao=;
        b=V+5KGG+m5VgNboOLDq4qe8tVig5EKVF/mTSl/YcwRJMIxP2S7/jNz29jMy0YAs69V1
         SwED1tWdOHqkmGkX3gRGodJrtOe0O4yf1hddhYZ2ADP+LONtG5PYLyYQfFtQZvIe6yXc
         k96p3Rl/TizMjYRdVU6pFjR4vwXUGplH/KnmNUFannsCFWdt2A3//h/xHD22v+Y1Tj2q
         ImKtcH8c2smOdFqM5S3kkD53fQsfSshbOMWnxFmhescWC/Y/+IHOLlOqEaufOIbofHDd
         EujL9cheANF1cvpPuFRvw6EJB6MxWoPRbzSPTcLbmgut2LFq/D/pdXlb67lsOkkmiPgu
         RFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWv2DXhpUZsQEN5stqt6YqBuhWFLoKxaG6XaaNvgSao=;
        b=Ya/9ktQk9N9CzKXpFLYM19xDkuSefp2EfN3Z5WBLfEE+t8W6wBp2l/QfC/jErlJJ5e
         Rd+3n3m9Z9aD2Jdo+z831wyM0bWX6g3ZmSJRwrMohJ+LwK1VDoh02UirIpZ0gf5JFk7z
         /XiJBWv2natFMrtEbJhzRa9MfTkIon0EApkxmnBYlXgvMEAwfsScILIkKpy43XeHEhVx
         oIHZ4owViGYl9Te8ufCkkFrQKIvQNoMc2zoQFicb3jhhhhW/lnKApTlXFLvTlFwaYzqN
         aQAF7Hy12aIgY5plmCYUVTBycT291UGS3KVSIpNyU2ROARFPl1QJHjHIT4t7qu5KBj7a
         UWwA==
X-Gm-Message-State: APjAAAWrGRtQCGXDGW+fS5huh952jGDwW9gNV4qoMWlcsCVzfrvK7O/8
        8A7ymytSVssPuYAalFeOrMX6pr2QwR4MYdIbCkQNhQ==
X-Google-Smtp-Source: APXvYqycIYm7gsfXjoF/75lGPYCl0UvFq4VrQ7oYhESMONziwYhWB3dOl13SRxlMjVldQZapAtess9+LraZ2pYF1e5Y=
X-Received: by 2002:ac2:4345:: with SMTP id o5mr5256449lfl.60.1571384940653;
 Fri, 18 Oct 2019 00:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191011071805.5554-1-linus.walleij@linaro.org>
 <20191011071805.5554-6-linus.walleij@linaro.org> <20191011134449.GA12969@bogus>
 <20191017222238.673cd60b@archlinux> <20191018072959.GS4365@dell>
In-Reply-To: <20191018072959.GS4365@dell>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 18 Oct 2019 09:48:49 +0200
Message-ID: <CACRpkdZBWK5BHi7TcPVrF1j3Fg4CgeMxLisn2JB-mPPA+uKS7w@mail.gmail.com>
Subject: Re: [PATCH 5/7 v4] mfd: ab8500: augment DT bindings
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Oct 18, 2019 at 9:30 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 17 Oct 2019, Jonathan Cameron wrote:

> Can you change the subject line to start with an uppercase char.
>
> Else my OCD sense will go into overdrive! ;)

Jonathan: it's fine to rebase the immutable branch for this as long as no-one
has pulled it in I suppose.

Working on a binding example cleanup.

Yours,
Linus Walleij
