Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2FD25697A
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 19:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgH2Rs6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 13:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbgH2Rs6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 13:48:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B97D2071B;
        Sat, 29 Aug 2020 17:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598723337;
        bh=4FzOl4RQy7xDxtwdaTv0obf0bNHOQwxc0nbIS/3k69E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TwdlZNiDDsRnX23TrhdBSJdDtX+gZKhjvOR9IPN6P/msWbQfubGHkVQw91YJ3758f
         ufR7s8qynh4peG9dwdpTJ3i1DIk8qBtmrtPmStxkaxxPWuxU4yxYN4Fr9Tz6Aiotnz
         5e5uQbArprfvt9J2ipZdxRe/OiKi0hED4vy42omc=
Date:   Sat, 29 Aug 2020 18:48:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: Re: [PATCH 02/13] dt-bindings: trivial-devices: Add mcp342x ADCs
 and drop separate binding doc.
Message-ID: <20200829184853.2f842501@archlinux>
In-Reply-To: <CAL_JsqLjgNx5U7S9+4ShJzofSr__mV6LkJaNVnuKmO+w0ksfrw@mail.gmail.com>
References: <20200809111753.156236-1-jic23@kernel.org>
        <20200809111753.156236-3-jic23@kernel.org>
        <CAL_JsqLjgNx5U7S9+4ShJzofSr__mV6LkJaNVnuKmO+w0ksfrw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Aug 2020 20:27:26 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Sun, Aug 9, 2020 at 5:20 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > These i2c devices have simple bindings, well described by trivial-device.yaml
> > so rather than convert the binding doc to yaml, let us just add them to
> > trivial devices and drop the old binding document.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/adc/mcp3422.txt   | 19 -------------------
> >  .../devicetree/bindings/trivial-devices.yaml  | 16 ++++++++++++++++
> >  2 files changed, 16 insertions(+), 19 deletions(-)  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied
