Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8C11E9807
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 16:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgEaOCm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 10:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgEaOCm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 10:02:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31BEC20723;
        Sun, 31 May 2020 14:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590933762;
        bh=D0gzVmbStb3PNrgx07STWnv6E9+eaE4lkytsQOUloMo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M5YdxIOv/f+cfB+IQz7cJj3I5UTNze3fSLSHeqbcYoLulWwuPK0oY0vv9tKYBtZ+v
         Evc/pjHzvVOmh3vmb/p/SVixEhR9kWoAqHzVGeWPn1smQWFyWlbpfWmSdE0Y/z1aRR
         P9H33oD7qhvnnqmJqYfi/O1naV+NW6uC7Gi9BRXo=
Date:   Sun, 31 May 2020 15:02:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, daniel.baluta@gmail.com,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 1/5] dt-bindings: iio: imu: bmi160: convert format to
 yaml, add maintainer
Message-ID: <20200531150237.106d8b83@archlinux>
In-Reply-To: <20200529170834.GA2578530@bogus>
References: <20200525164615.14962-1-jonathan.albrieux@gmail.com>
        <20200525164615.14962-2-jonathan.albrieux@gmail.com>
        <20200529170834.GA2578530@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 May 2020 11:08:34 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, 25 May 2020 18:46:00 +0200, Jonathan Albrieux wrote:
> > Converts documentation from txt format to yaml.
> > 
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/imu/bmi160.txt    | 37 ---------
> >  .../bindings/iio/imu/bosch,bmi160.yaml        | 75 +++++++++++++++++++
> >  2 files changed, 75 insertions(+), 37 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to poke at.

Thanks,

Jonathan
