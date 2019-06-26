Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C187756C83
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 16:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfFZOqL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 10:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbfFZOqL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 10:46:11 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98AE821783;
        Wed, 26 Jun 2019 14:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561560370;
        bh=SgyRfp9j7tfDF2c5zsUeeU2JMpNmn9znBEtJ6Ddu9QY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SIY9hQ9fFwomEsBSURsShUDPM8BvOAH8wO4E5PXLrYtpdkkFLFL4w5AHqpYKu8OQ2
         OoeUVh8DS/+qnGe0cZfRGU26VizBmkTD9xY4Mue9dLOG58xt/L2GJj4Z4vESrNfeR8
         LG4/3+MXoaejOefk8OIPn8QpUeAQbbbsDoaYU7Q4=
Received: by mail-qk1-f179.google.com with SMTP id p144so1824377qke.11;
        Wed, 26 Jun 2019 07:46:10 -0700 (PDT)
X-Gm-Message-State: APjAAAUNxGyKdyPE/MnMxzfi8UVPAdyVDZ4v7OFTzjb9dpDsRa7dJ5UI
        pUQcvm1JDRh3SQ5k6X0V+q5wnt7Zd9I6FDr5cQ==
X-Google-Smtp-Source: APXvYqw5283L56Gc8KaJlBZugufdawjb75R3b1nrUhcsh0uoda7ucgzw0oPalXh8dy9pMWHJfV2n5NxWNW5JU9n1iCQ=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr4324838qke.223.1561560369873;
 Wed, 26 Jun 2019 07:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <1561389162-26291-1-git-send-email-stefan.popa@analog.com>
In-Reply-To: <1561389162-26291-1-git-send-email-stefan.popa@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Jun 2019 08:45:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKW5qKYOXD8N=uCdoUxuw9iT+Lw-NhJuUuUPWj0dzdv-Q@mail.gmail.com>
Message-ID: <CAL_JsqKW5qKYOXD8N=uCdoUxuw9iT+Lw-NhJuUuUPWj0dzdv-Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: iio: frequency: Add ADF4372 PLL documentation
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

On Mon, Jun 24, 2019 at 9:40 AM Stefan Popa <stefan.popa@analog.com> wrote:
>
> Document support for ADF4372 SPI Wideband Synthesizer.
>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/frequency/adf4371.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
