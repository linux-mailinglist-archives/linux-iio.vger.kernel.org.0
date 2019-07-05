Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E9960A2D
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2019 18:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfGEQXZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Jul 2019 12:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfGEQXZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 Jul 2019 12:23:25 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F314218CA;
        Fri,  5 Jul 2019 16:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562343804;
        bh=DjO00UEeURnOprUG5mN+2U9KI5+oYy0rMuZBSb5mW2o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a0jDfkTYC72T/YJYLKK1nGc7hSNO8lVHk9qMVpswBcrz9WNprUQ3XaV8DHlgd2vaU
         hMcpwoCtyEBxGLMQqKawyocV5Eueb6cMwrv+u84XmFTBjy+MkBZk7zJrdBitzGa2OW
         9Bfc5FePfUMYd6YciPsYQ8c5U782GQzyQ8YrdTdw=
Received: by mail-qk1-f170.google.com with SMTP id r21so7998913qke.2;
        Fri, 05 Jul 2019 09:23:24 -0700 (PDT)
X-Gm-Message-State: APjAAAWuNN+WIqxzeWKHxTbmdiCOmFQb7tU09TAXaPgme7GvvvnNsNaZ
        lRqjCC6UiaSU9O8Tv8V38XmEDooqLfQAmsjAkQ==
X-Google-Smtp-Source: APXvYqy/0g0M78QUbCdgY0Xp/Y0bTbmSVCD16U1+TXU2RK0KVT9aQc6q4SpKS2zq2GeE4Ocqd7cuWKEJcuuhl4Xrw78=
X-Received: by 2002:a37:a44a:: with SMTP id n71mr2160286qke.393.1562343803430;
 Fri, 05 Jul 2019 09:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190703180604.9840-1-luca@z3ntu.xyz> <20190703180604.9840-2-luca@z3ntu.xyz>
In-Reply-To: <20190703180604.9840-2-luca@z3ntu.xyz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 5 Jul 2019 10:23:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJU5nBf+tzudpXVseeb8FMoJUK3ANJs3btb=6gbcG41EA@mail.gmail.com>
Message-ID: <CAL_JsqJU5nBf+tzudpXVseeb8FMoJUK3ANJs3btb=6gbcG41EA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: light: add stk33xx
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Vivek Unune <npcomplete13@gmail.com>,
        Hannes Schmelzer <hannes.schmelzer@br-automation.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Martijn Braam <martijn@brixit.nl>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ~martijnbraam/pmos-upstream@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 3, 2019 at 12:06 PM Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Add binding documentation for the stk33xx family of ambient light
> sensors.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  .../bindings/iio/light/stk33xx.yaml           | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/stk33xx.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
