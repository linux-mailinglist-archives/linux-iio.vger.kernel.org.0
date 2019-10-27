Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA86E61D2
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2019 10:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfJ0J2u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 05:28:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfJ0J2u (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Oct 2019 05:28:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A56220717;
        Sun, 27 Oct 2019 09:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572168529;
        bh=PZM3D1GXhdG5lOJWfQbsfdy1YZDVQmsqvBbU6UgwVDA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gat9zT3OSoJCzLKmGVRnwnnjkfZmqFXk85LnSE7kyda0t/6oRLTJHsCpQhMEu6MPZ
         EuMQn+l6Ta4b+GJCqCaNSyaYMZQ2u9sz8o8suL4m1lCgJeV9pSWnc1TulPLpK0sqip
         REdZUZRhFTTqCP0qJ5HFVl7giZQP1RieIhTORewo=
Date:   Sun, 27 Oct 2019 09:28:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     dragos.bogdan@analog.com, alexandru.ardelean@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 1/2] iio: adc: Add driver support for AD7292
Message-ID: <20191027092845.5a1269f5@archlinux>
In-Reply-To: <20191022142736.ztch3mzqpv6jcvhm@smtp.gmail.com>
References: <20191016025119.53fclzngzt5qwlmk@smtp.gmail.com>
        <20191021180644.3a260af2@archlinux>
        <20191022142736.ztch3mzqpv6jcvhm@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Oct 2019 11:27:37 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hi Jonathan,
> 
> Should I send a V3 for the whole patchset or just for the DT binding patch?

Always send whole patch sets.  It's far too fiddly to track down parts
from different versions.

Thanks,

Jonathan

> 
> Thanks,
> 
> Marcelo
> 
> On 10/21, Jonathan Cameron wrote:
> > On Tue, 15 Oct 2019 23:51:22 -0300
> > Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> >   
> > > The AD7292 is a 10-bit monitor and control system with ADC, DACs,
> > > temperature sensor, and GPIOs.
> > > 
> > > Configure AD7292 devices in direct access mode, enabling single-ended
> > > ADC readings.
> > > 
> > > Datasheet:
> > > Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ad7292.pdf
> > > 
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>  
> > This looks fine to me.
> > 
> > Assuming nothing else comes up, I'll pick this up once the binding was tidied up.
> > 
> > Thanks,
> > 
> > Jonathan
> >   

