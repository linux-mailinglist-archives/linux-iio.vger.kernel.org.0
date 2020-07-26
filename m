Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AFF22DF05
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jul 2020 14:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgGZMeb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jul 2020 08:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgGZMeb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Jul 2020 08:34:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22D69206D8;
        Sun, 26 Jul 2020 12:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595766871;
        bh=eAlrwCkGaxj2oiht2tjkTxM5eF+LRyV8H2S//rwKV3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EMBU7P7XKWlZRdrGObVzCaZwqdkb14rHsmAp7n15osZp8wx49LWa3Syiw2oA9TS5q
         kSHyjJDwrdoLxwWOr5Ab49nMsKhDeBNMessWObwGf3Uwyj9kDGjOByrQCLJUyPZNGj
         35bFaFl0wX/MMpw4OHFKP3RDJW/8bnW/1hfKpVX8=
Date:   Sun, 26 Jul 2020 13:34:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: chemical: add O2 EZO module
 documentation
Message-ID: <20200726133427.711b4157@archlinux>
In-Reply-To: <20200723174731.GA596034@bogus>
References: <20200720070330.259954-1-matt.ranostay@konsulko.com>
        <20200720070330.259954-3-matt.ranostay@konsulko.com>
        <20200723174731.GA596034@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Jul 2020 11:47:31 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, 20 Jul 2020 00:03:29 -0700, Matt Ranostay wrote:
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> > ---
> >  .../devicetree/bindings/iio/chemical/atlas,sensor.yaml          | 2 ++
> >  1 file changed, 2 insertions(+)
> >   
> 
> Acked-by: Rob Herring <robh@kernel.org>
Applied.

Thanks,

