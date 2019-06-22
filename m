Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4D254F473
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 10:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfFVIsz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 04:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfFVIsz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 04:48:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50AE3206BA;
        Sat, 22 Jun 2019 08:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561193334;
        bh=+jJMhm50tZhIKwXwnTVQfJQxfk46YzI7SOYvUv3LD+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MABH9LOMcHbPiIs0fsfkNsPq4u+tZACIETiJwdl0x3xUDB5I5HJpovmcMx4cFXqGt
         Az9RWUVVM2ZRR+j4vKMYUd7rmG0tz2JboL0FTo25RJY4d2zg7YX8onRIVVs88RjJ85
         AcaVXJaidqyh7YuAich6puxyN4u20sIo1LYO/cV0=
Date:   Sat, 22 Jun 2019 09:48:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: chemical: sps30: convert bindings
 to yaml
Message-ID: <20190622094850.6d0bea9e@archlinux>
In-Reply-To: <CAL_JsqLmZPTYqSkmSo-KuqUr7FY1BqE3XX7+PhcA_0phS4X3jQ@mail.gmail.com>
References: <20190620195011.30942-1-tduszyns@gmail.com>
        <20190620195011.30942-2-tduszyns@gmail.com>
        <CAL_JsqLmZPTYqSkmSo-KuqUr7FY1BqE3XX7+PhcA_0phS4X3jQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 20 Jun 2019 15:21:47 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Thu, Jun 20, 2019 at 1:52 PM Tomasz Duszynski <tduszyns@gmail.com> wrote:
> >
> > Convert existing device tree bindings to yaml.
> >
> > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> > ---
> >  .../bindings/iio/chemical/sensirion,sps30.txt | 12 ------
> >  .../iio/chemical/sensirion,sps30.yaml         | 39 +++++++++++++++++++
> >  2 files changed, 39 insertions(+), 12 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
