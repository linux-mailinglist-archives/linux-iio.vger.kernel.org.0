Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F42001A88BE
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 20:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503536AbgDNSMM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 14:12:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503474AbgDNSLE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 14:11:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2975A20767;
        Tue, 14 Apr 2020 18:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586887863;
        bh=oD8j10JIJKIL0ur0Xx6pmA3upO35OAZti57bpnMdN3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z6H90bv8rJYDsjsU1q/VwLUlFDaqr9jNItt1R7XKfLMtrDa7STNJM1mLN/PblmkLT
         R6hw9g8IT2oU1CrvRW7dRX03UN+2+JmLD1gBHu2VkS5NMpm8TLxpKwToDOitDfi3Wy
         KkqHe0tST0+Q8dre5ZRSjcvJFdTTvTwhBcxLxehs=
Date:   Tue, 14 Apr 2020 19:10:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Alexandru Lazar <alazar@startmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: adc: Add MAX1241 bindings
Message-ID: <20200414191059.3088b0c5@archlinux>
In-Reply-To: <20200414174503.GA11705@bogus>
References: <20200403121323.1742-1-alazar@startmail.com>
        <20200403121323.1742-2-alazar@startmail.com>
        <20200414174503.GA11705@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Apr 2020 12:45:03 -0500
Rob Herring <robh@kernel.org> wrote:

> On Fri,  3 Apr 2020 15:13:22 +0300, Alexandru Lazar wrote:
> > Add device-tree bindings documentation for the MAX1241 device driver.
> > 
> > Signed-off-by: Alexandru Lazar <alazar@startmail.com>
> > ---
> >  .../bindings/iio/adc/maxim,max1241.yaml       | 64 +++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Added.  Thanks Rob!

Jonathan
