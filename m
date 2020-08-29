Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F36256994
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 19:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgH2R63 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 13:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbgH2R62 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 13:58:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDBEA2071B;
        Sat, 29 Aug 2020 17:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598723907;
        bh=d3dYzeHtmRmNqGk8SebLmNuCzY0bIb5Myjt2u5BVhp8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=08GmWWsRU+Yw+FmQSLAM6PtukQRwPm2Ff4j4pu7MHia91CK1ERKNjBRdgBtRLQrIO
         HuO5OrjcBOPbtgmgZ39cFFEhL7LIBX+MtW3KzPAmif8B1xUAxwFZtNsJpsy7w+vCMJ
         2rRbkkpQ4CtGIg7+ECvqIy9bbke9hYj14tJFdSTM=
Date:   Sat, 29 Aug 2020 18:58:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 11/13] dt-bindings: iio: adc: ti,ads8344 yaml conversion
Message-ID: <20200829185823.2c3f673a@archlinux>
In-Reply-To: <20200818023156.GA2174856@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
        <20200809111753.156236-12-jic23@kernel.org>
        <20200818023156.GA2174856@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Aug 2020 20:31:56 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, 09 Aug 2020 12:17:51 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Simple binding so easy to convert.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  .../bindings/iio/adc/ti,ads8344.yaml          | 51 +++++++++++++++++++
> >  .../bindings/iio/adc/ti-ads8344.txt           | 19 -------
> >  2 files changed, 51 insertions(+), 19 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied
