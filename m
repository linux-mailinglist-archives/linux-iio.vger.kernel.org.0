Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8F9D500C
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 15:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfJLNXY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 09:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfJLNXY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 09:23:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9C612087E;
        Sat, 12 Oct 2019 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570886604;
        bh=LeXnAiJm88QvFHwnWGZQ1G2GMcsvJcbDbZ03laAOCEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TIuCHLxUyUt/h3TR3okqYiUXPUZ1w8rwzuZkZiW58u1i7ENA4ij3zvL3pvGC7NtPH
         mgZgY4piIeDlNdHsWJP134XEHfoZW/J4NEH+IGxwcI2yTgATmYRijUFElqW01OTOiW
         flJtKY+yk1kEWHkIzzQqY/jiRpAwso2C35g+CcSo=
Date:   Sat, 12 Oct 2019 14:23:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andreas Klinger <ak@it-klinger.de>, robh+dt@kernel.org,
        mark.rutland@arm.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: iio: maxbotix,mb1232.yaml: transform to
 yaml
Message-ID: <20191012142318.03057c61@archlinux>
In-Reply-To: <20191010205328.GA19956@bogus>
References: <20191007170219.xfipsry5nk4raiem@arbad>
        <20191010205328.GA19956@bogus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Oct 2019 15:53:28 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, 7 Oct 2019 19:02:20 +0200, Andreas Klinger wrote:
> > transform existing documentation of maxbotix,mb1232 ultrasonic ranger
> > from text documentation format into yaml.
> > 
> > Changes in v3:
> > - add a i2c node around device node to set up #address-cells and
> >   #size-cells for omitting error during make dt_binding_check
> > 
> > Changes in v2:
> > - removed description of reg property
> > - added a line:
> >   additionalProperties: false
> > 
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > ---
> >  .../bindings/iio/proximity/maxbotix,mb1232.txt     | 29 -----------
> >  .../bindings/iio/proximity/maxbotix,mb1232.yaml    | 60 ++++++++++++++++++++++
> >  2 files changed, 60 insertions(+), 29 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for the 
autobuilders to play with it.

Thanks,

Jonathan


