Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA89C27D2AD
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 17:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgI2P1q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 11:27:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgI2P1p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Sep 2020 11:27:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49F7220773;
        Tue, 29 Sep 2020 15:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601393265;
        bh=28J5Xqnu8HqFsJcPfiPiJszNONTsRfXlkXep+D/a558=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d6eQ1opvgx7r1DZYDCYw1sZacOG4Op6OPkt5+GqnHTNy5fJZ7uJiJP2CustpQ3m9i
         BpyhJuVfKEXR0baNVGfemQUuehjFzMz+KZMdEWLVZ9g23ShiNXNsu2xrDncJuC8/GG
         a9AqoFp8hi01e3Ma3UKJl+69LMzi7bJAwqLH1/wg=
Date:   Tue, 29 Sep 2020 16:27:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Valdis =?UTF-8?B?S2zEk3RuaWVr?= =?UTF-8?B?cw==?= 
        <valdis.kletnieks@vt.edu>, Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/18] counter: use semicolons rather than commas to
 separate statements
Message-ID: <20200929162739.40c8257e@archlinux>
In-Reply-To: <be1d59c5-fd0c-821e-0357-441c26c3d16c@lechnology.com>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
        <1601233948-11629-16-git-send-email-Julia.Lawall@inria.fr>
        <be1d59c5-fd0c-821e-0357-441c26c3d16c@lechnology.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Sep 2020 10:37:28 -0500
David Lechner <david@lechnology.com> wrote:

> On 9/27/20 2:12 PM, Julia Lawall wrote:
> > Replace commas with semicolons.  What is done is essentially described by
> > the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):
> > 
> > // <smpl>
> > @@ expression e1,e2; @@
> > e1
> > -,
> > +;
> > e2
> > ... when any
> > // </smpl>
> > 
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> > 
> > ---  
> Reviewed-by: David Lechner <david@lechnology.com>
I've picked this one up.  Applied to the togreg branch of iio.git and
pushed out as testing for all the normal reasons.

Thanks,

Jonathan

> 

