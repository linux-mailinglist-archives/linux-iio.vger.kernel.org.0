Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 406C218E353
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 18:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgCUR1M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 13:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727446AbgCUR1M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 13:27:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB67E20724;
        Sat, 21 Mar 2020 17:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584811631;
        bh=3ksjJIAAOUg1ecU4WyAkFJxmKgf0jA+PcibciZVU7Sw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NutM9NengGxNFN5lShngFlwliMbpiOR1+Ltl58MXIKGaL3fgt26nKzz0J81U12Zmp
         Z7Lf97eGxLIZstxKlAEAKCESiR7EWPqPk3K06rWza5y/jq0/2oET4I56/3atVc7sMW
         IK9YBeBqQ4LI/RMsXriqkKRG5xlLiqUSa4+1cTXU=
Date:   Sat, 21 Mar 2020 17:27:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "tachicialex@gmail.com" <tachicialex@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/2] iio: dac: ad5770r: dt bindings fixes
Message-ID: <20200321172707.50f57bbc@archlinux>
In-Reply-To: <5a7729473f13cd7e9991b1ce0c1567d770eeb3e3.camel@analog.com>
References: <20200320160531.23732-1-alexandru.tachici@analog.com>
        <5a7729473f13cd7e9991b1ce0c1567d770eeb3e3.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Mar 2020 07:17:30 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Fri, 2020-03-20 at 18:05 +0200, Alexandru Tachici wrote:
> > [External]
> > 
> > This aims to replace use of num property from dt nodes with
> > reg property both in dt bindings and driver and fix
> > dt bindings errors.
> >   
> 
> Maybe do a RESEND for this and add
> --to=devicetree@vger.kernel.org --cc=robh+dt@kernel.org
> to the git send-mail command
> 
> Specifically for this, the DT list should be addressed.
> But [naturally] the IIO list should also be included.

Definitely do this resend.  I'll want an review from Rob.

Thanks,

Jonathan

> 
> 
> > 1. read from fwnode reg property instead of num property
> > 
> > 2. replace num property with reg property and fix dt
> > bindings errors
> > 
> > Alexandru Tachici (2):
> >   iio: dac: ad5770r: read channel nr from reg
> >   dt-bindings: iio: dac: AD5570R fix bindings errors
> > 
> >  .../bindings/iio/dac/adi,ad5770r.yaml         | 77 ++++++++++---------
> >  drivers/iio/dac/ad5770r.c                     |  2 +-
> >  2 files changed, 41 insertions(+), 38 deletions(-)
> >   

