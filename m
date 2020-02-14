Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 909CF15D925
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 15:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgBNOOg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 09:14:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgBNOOg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 09:14:36 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BD9622314;
        Fri, 14 Feb 2020 14:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581689675;
        bh=MdUO0h05smc5KdaA/ZHU+8UH3vmdkaFGEznUM+x2ln0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1TQuwJkyrEDG4Zr88Ezq/kTRwslgZb2nVK7InN9NPN/GVvirKoPCthI2W0DFt1Ox7
         U8nrLVd70NwvueEgl07oC+54n8P6vV1pkCUXG+Quxa4yr5AGLUhKugb9Ml4w3knVYX
         48hBBtliu6D9hHX/2PcamWgsyd+F+Rgj0syqUguk=
Date:   Fri, 14 Feb 2020 14:14:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Beniamin Bia <beniamin.bia@analog.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        biabeniamin@outlook.com, knaack.h@gmx.de, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 4/5] dt-bindings: iio: amplifiers: Add docs for
 HMC425A Step Attenuator
Message-ID: <20200214141430.2a3780c8@archlinux>
In-Reply-To: <20200206213427.GA12507@bogus>
References: <20200206151149.32122-1-beniamin.bia@analog.com>
        <20200206151149.32122-4-beniamin.bia@analog.com>
        <20200206213427.GA12507@bogus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 6 Feb 2020 14:34:27 -0700
Rob Herring <robh@kernel.org> wrote:

> On Thu, Feb 06, 2020 at 05:11:48PM +0200, Beniamin Bia wrote:
> > From: Michael Hennerich <michael.hennerich@analog.com>
> > 
> > Document support for Analog Devices MC425A Step Attenuator.
> > 
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> > ---
> > Changes in v5:
> > -minItems added for ctrl_gpios
> > 
> >  .../bindings/iio/amplifiers/adi,hmc425a.yaml  | 49 +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.  Thanks,

Jonathan
