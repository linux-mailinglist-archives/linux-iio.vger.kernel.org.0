Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0D937FA1B
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 16:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbhEMO4i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 13 May 2021 10:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234782AbhEMOz4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 10:55:56 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65AF961433;
        Thu, 13 May 2021 14:54:44 +0000 (UTC)
Date:   Thu, 13 May 2021 15:55:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Alexandru Lazar <alazar@startmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: remove unused private data assigned with
 spi_set_drvdata()
Message-ID: <20210513155552.12f64241@jic23-huawei>
In-Reply-To: <CA+U=DsrSjQa-iL5FHyiwXN=Hv72jd5b99tzcNoO97ckXgiuGzA@mail.gmail.com>
References: <20210513111035.77950-1-aardelean@deviqon.com>
        <a31b6d94-24cc-6f01-dc36-90c0001ea396@startmail.com>
        <CA+U=DsrSjQa-iL5FHyiwXN=Hv72jd5b99tzcNoO97ckXgiuGzA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 13 May 2021 15:14:57 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, May 13, 2021 at 3:06 PM Alexandru Lazar <alazar@startmail.com> wrote:
> >
> >  
> > > Some drivers were copied from drivers that fit the criteria described
> > > above. In any case, in order to prevent more drivers from being used as
> > > example (and have spi_set_drvdata() needlessly set), this change removes it
> > > from the IIO ADC group.  
> >
> > Oh yeah, I'm pretty sure that's how I ended up adding it in the max1241
> > code, too. Code monkey presents humble apologies :-).  
> 
> Well, I also added one in the AD9467 driver in the same manner.
> So  ¯\_(ツ)_/¯
> 
All look correct to me. I'll let this sit on the list for a few days before
picking it up.

Thanks,

Jonathan

> >
> > All the best,
> > Alex  

