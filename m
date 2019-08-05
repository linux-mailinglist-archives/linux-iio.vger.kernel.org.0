Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F98381EE9
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 16:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfHEOTy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 10:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728863AbfHEOTy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 10:19:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 016B2206C1;
        Mon,  5 Aug 2019 14:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565014794;
        bh=91sFixUWOsEDwpbyOklHrTrH1uIRcz5WMAeevBWfmdU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MdU2qodB47Rgwiv16fLK31yDOY21RhCx/3ZEX+Aewt5o+C/zuGTuofgPKt5AKAQS3
         3v4kTlUaK9ouHS7EKRj6+fWyXWXiiAb7cZB6iJDRohnDuP3bMlG+PlJY9zq+1YYdeo
         VMNLWJ9gBke0bymVqPNQmb39MfMmf79ahhjFqdlM=
Date:   Mon, 5 Aug 2019 15:19:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, lorenzo.bianconi@redhat.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: imu: st_lsm6dsx: move iio chan definitions
 in st_lsm6dsx_sensor_settings
Message-ID: <20190805151949.20a5584d@archlinux>
In-Reply-To: <dff3f76d-a4f7-bed2-496f-daa0139ee1b0@puri.sm>
References: <cover.1564427804.git.lorenzo@kernel.org>
        <f4adc084ad92c1c31c2ed9cc748321c29e457c1c.1564427804.git.lorenzo@kernel.org>
        <dff3f76d-a4f7-bed2-496f-daa0139ee1b0@puri.sm>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2 Aug 2019 07:36:03 +0200
Martin Kepplinger <martin.kepplinger@puri.sm> wrote:

> On 29.07.19 21:22, Lorenzo Bianconi wrote:
> > Move IIO channel definitions in st_lsm6dsx_sensor_settings in order to
> > support sensors with different channels maps.
> > This is a preliminary patch to add support for LSM9DS1 sensor to
> > st_lsm6dsx driver.
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 +
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 96 ++++++++++++++++----
> >  2 files changed, 81 insertions(+), 20 deletions(-)  
> 
> 
> thanks. I'm running this patchset now and will resend LSM9DS1 patches
> after these are merged.
> 
> Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Applied and a particular thanks for the tested-by's.

Thanks,

Jonathan

> 

