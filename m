Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01CF9E0833
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 18:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389099AbfJVQD4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 12:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387746AbfJVQD4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Oct 2019 12:03:56 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E39F21906;
        Tue, 22 Oct 2019 16:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571760235;
        bh=wZqpmahqkdwN8bSUWflCybWpGAN6ZEbtQZB3qCoZljg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kfdQNIrvB/s9H8KQC7rO59/l3ydNVyU/ihPEcbQgqHc8iYlLgPGNP53znI1XGkZbp
         zKp9BNTuVAovRoYJsjf0ve98p9jxSW+o5aOdHl3RUA2eSeb5OZHAVyfbDGCyhl2YOe
         swTrBGgRroC8KtsMuhpKGF8CHBPraGYjLhOee4NY=
Received: by mail-qt1-f174.google.com with SMTP id c21so27497198qtj.12;
        Tue, 22 Oct 2019 09:03:55 -0700 (PDT)
X-Gm-Message-State: APjAAAUiRov13Q4nl311SaYm+NmPw+IsM68HfJdrep2TI4MIJE9HtocR
        N6y9j05t/isX8pmBUPOcEbPa5te3nymJcMoqGg==
X-Google-Smtp-Source: APXvYqyyB49iT/626fOA+V3xooxxBwy9dN/zE/XUizKQfbN9LeELAEH0K+nxf/XITvR19bMhVI+BTk4qKYDqfrxtpdo=
X-Received: by 2002:ac8:44d9:: with SMTP id b25mr4261906qto.300.1571760234567;
 Tue, 22 Oct 2019 09:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191016025220.td3xb7oxlfkznxl6@smtp.gmail.com>
 <20191017191152.GA11222@bogus> <20191019150652.h6bkfz2w2ohemvwy@smtp.gmail.com>
 <CAL_JsqKqgko02KstmytNNUUF0-QR7rpMF4dV=X55N=TnDahd+Q@mail.gmail.com> <20191022140604.ovmooly47qax2sms@smtp.gmail.com>
In-Reply-To: <20191022140604.ovmooly47qax2sms@smtp.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Oct 2019 11:03:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLf8kpOu0MQN-TAhQkiZCGfMKWmztnHNo+2BAVqfX8yGQ@mail.gmail.com>
Message-ID: <CAL_JsqLf8kpOu0MQN-TAhQkiZCGfMKWmztnHNo+2BAVqfX8yGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: Add DT docs for AD7292
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 22, 2019 at 9:06 AM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Hi,
>
> I ran the DTC and CHECK for AD7292 schema however, the target '__build'
> did not run due to errors found in regulator/fixed-regulator.yaml and
> arm/allwinner,sun4i-a10-csi.yaml.

Fixes for those are still pending in -next. Use 'make -k' and ignore those.

>
> I recall seeing something about the maxItems requirement over regulator
> supplies being changed on the iio mailing list, so I updated my repo
> locally, cloned and reinstalled the dt-schema toolset. However, I still
> can't make it go through the '__build' target.
>
> Python 3.7.5rc1 is my default python and I got the following pip3
> packages installed:
>
> ruamel.yaml        0.16.5
> ruamel.yaml.clib   0.2.0
> rfc3987            1.3.8
> jsonschema         3.0.1
> dtschema           0.0.1  at $HOME/<iio repo dir>/dt-schema
>
> Debian Bullseye packages installed:
> python3-yaml/testing,now 5.1.2-1
> libyaml-dev/testing,now 0.2.2-1
>
> I was only able to run DTC after installing the libyaml-dev package, so
> I think it might be worth to add it to the project dependencies at
> https://github.com/robherring/dt-schema.

Strictly speaking, it's not a dependency for dt-schema. It's
documented in Documentation/devicetree/writing-schema.rst. I've added
a pointer to that in bindings/submitting-patches.txt. I'm not sure how
else to make it more obvious.

BTW, You will get a useful error message if libyaml is missing when
building 'make dtbs_check'. I need to make that work for
dt_binding_check.

> apt-get install libyaml-dev

You need the lib too, but that tends to already be installed. IIRC,
installing the headers doesn't install the lib automatically.

In any case, I wanted to avoid putting in distro specific instructions
in the kernel.

Rob
