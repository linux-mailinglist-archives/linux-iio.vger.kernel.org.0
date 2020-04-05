Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8DF19ECDB
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 19:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgDERUL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 13:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbgDERUL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 13:20:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2961220675;
        Sun,  5 Apr 2020 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586107211;
        bh=cXV0BPP7MSfuBIRSfiwTxlAduhs+AzJF9b9Ou+P6Xrw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MXKg54NlrrlmpbhV4+FXKIO9Nth+d4lo95G3w7ZWOFyaD+/S9l+zh5LVD7ZVTmAtr
         yKaWSfBGjp7lNH5q4+HORO70e+OBB0hwGxj9jx1zBOoMCTyGripeSRSaX6R5Rw3d8C
         88zLmqcxd8zjsj1bqvJoHe4Jm5TRFhC55ZpuOLUk=
Date:   Sun, 5 Apr 2020 18:20:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: xilinx-xadc: Fix ADC-B powerdown
Message-ID: <20200405182007.3d0ce357@archlinux>
In-Reply-To: <195740ae-392f-5d6b-6042-f09e315847dd@metafoo.de>
References: <20200403132717.24682-1-lars@metafoo.de>
        <20200405131039.37ae5165@archlinux>
        <55c93588-2242-2ccb-2d8e-50cc66de28f5@metafoo.de>
        <20200405132602.65a7a480@archlinux>
        <195740ae-392f-5d6b-6042-f09e315847dd@metafoo.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 5 Apr 2020 14:29:00 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 4/5/20 2:26 PM, Jonathan Cameron wrote:
> > On Sun, 5 Apr 2020 14:13:32 +0200
> > Lars-Peter Clausen <lars@metafoo.de> wrote:
> >  
> >> On 4/5/20 2:10 PM, Jonathan Cameron wrote:  
> >>> On Fri,  3 Apr 2020 15:27:13 +0200
> >>> Lars-Peter Clausen <lars@metafoo.de> wrote:
> >>>     
> >>>> The check for shutting down the second ADC is inverted. This causes it to
> >>>> be powered down when it should be enabled. As a result channels that are
> >>>> supposed to be handled by the second ADC return invalid conversion results.
> >>>>
> >>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>  
> >>> Fixes tag?  Definitely sounds like something we should be backporting!  
> >> Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")  
> > For all of them? (just checking)  
> Yes, took 6 years for somebody to notice :)
We've had ones that took longer :)

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan


