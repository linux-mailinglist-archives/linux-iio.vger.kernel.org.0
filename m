Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31782FE0C3
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 16:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfKOPAm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 10:00:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbfKOPAm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 15 Nov 2019 10:00:42 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FE192075E;
        Fri, 15 Nov 2019 15:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573830041;
        bh=e6AqUu0tvIsjZpg7MkGAdgpO+2f9FFqD80mC49I3A1w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FiDx/Atpmvy/JB5JQSBRXq+jhgF8zuiC9eeQVLUPzR08zTEenqcITIvRgkedeZccJ
         yG1bwrhRau/BG55Ld5/t7pUpCKiiWf+LNRVj4FjfTuVo9ZDnviNHaucxSRF0kDtEVs
         P1wNqDWuHGMG5xk6Vuz8FRWktfom61G+ImoDQcVw=
Received: by mail-qt1-f178.google.com with SMTP id r20so11043745qtp.13;
        Fri, 15 Nov 2019 07:00:41 -0800 (PST)
X-Gm-Message-State: APjAAAV7L/AqO+FaEVOz6+k/53q8kFzJK9JlycKgp2J3Y+RktzQ9dc1K
        PYIes+OffAiohkb71H24iEbLSD/mVpNOXHRl7Q==
X-Google-Smtp-Source: APXvYqya8dDmgqMXFYG+B2TXV92bU4T/lbXrVVmBGbEe9H1TzMG+IxXMhC9StqYyWHztu8gou6AA7UkUXzPHvR3099w=
X-Received: by 2002:ac8:7612:: with SMTP id t18mr14221857qtq.143.1573830040314;
 Fri, 15 Nov 2019 07:00:40 -0800 (PST)
MIME-Version: 1.0
References: <20191115074424.cnk3xleobvusfuci@arbad>
In-Reply-To: <20191115074424.cnk3xleobvusfuci@arbad>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 15 Nov 2019 09:00:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJHAGoBwwrLZezVNrZbUwKmS=+xVw_6h9R_=uGea+YDEA@mail.gmail.com>
Message-ID: <CAL_JsqJHAGoBwwrLZezVNrZbUwKmS=+xVw_6h9R_=uGea+YDEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: add parallax ping sensors
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        David Miller <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        devicetree@vger.kernel.org,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Nov 15, 2019 at 1:44 AM Andreas Klinger <ak@it-klinger.de> wrote:
>
> Add dt-bindings for parallax PING))) and LaserPING iio sensors, which
> are used for measuring distances.
>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../bindings/iio/proximity/parallax-ping.yaml      | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
