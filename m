Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 199D61F5F9
	for <lists+linux-iio@lfdr.de>; Wed, 15 May 2019 15:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfEONvx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 May 2019 09:51:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfEONvx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 15 May 2019 09:51:53 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62A672166E;
        Wed, 15 May 2019 13:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557928312;
        bh=PeQ3v+aUDLOT5wUt7DdAGsAwXfG7pZkDyLgC5I73JRc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TcHrETGBS5RK4vA7Qrv64nPQh0cwDiqgjbiIp8uCc2kwrlGH/yb9DAaM0iZCbuwyu
         fnpXE0xxj6dj9aGKPtkTWQ6RTovDQIySmxUz9EPy+qFIlajftuLCZOT/wE5R6PNngc
         JBN5IzmDhqfBcXiTa0x5XNH9tra5Q4QcYL8fMTRo=
Received: by mail-qt1-f171.google.com with SMTP id y42so3321996qtk.6;
        Wed, 15 May 2019 06:51:52 -0700 (PDT)
X-Gm-Message-State: APjAAAVUSAY6vw4WTTBKlq9llS9SHkV09yVJfCwB6hAUVcXOqX5GJKPG
        f2OAZBzYlumn7RBxF9j2/Ha9Edy/yUdlCULBqQ==
X-Google-Smtp-Source: APXvYqxt06BGJpuvl0NUUvAZaOE9f10w4Lhh10Lw/WolvqFjTTNJPssHz/Fa2Aey082LghVWTDP5JtVqelqf2Ba6ofo=
X-Received: by 2002:aed:2471:: with SMTP id s46mr36118156qtc.144.1557928311668;
 Wed, 15 May 2019 06:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <1557918043-25733-1-git-send-email-stefan.popa@analog.com>
In-Reply-To: <1557918043-25733-1-git-send-email-stefan.popa@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 15 May 2019 08:51:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKvHBoKiMUaA8=rLtM_kCMas8sQgp+k6DTKgUfpVX3+iQ@mail.gmail.com>
Message-ID: <CAL_JsqKvHBoKiMUaA8=rLtM_kCMas8sQgp+k6DTKgUfpVX3+iQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: iio: frequency: Add docs for ADF4371 PLL
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 15, 2019 at 6:00 AM Stefan Popa <stefan.popa@analog.com> wrote:
>
> Document support for Analog Devices ADF4371 SPI Wideband Synthesizer.
>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  .../devicetree/bindings/iio/frequency/adf4371.yaml | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adf4371.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
