Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AECEA81EE5
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 16:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfHEOSu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 10:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728863AbfHEOSu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 10:18:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C415214C6;
        Mon,  5 Aug 2019 14:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565014730;
        bh=znMMN1EfRWBJzohJRkmjsaIGNBpejS3HcM3LTjH+hdI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IEgkZjp4R2mC+6YdWD9qLAhFqVBHoOJKRv38uMJhxJfZ+i8q93ix5W1dL/0DbxtZn
         VEJMit1LwZBvvNnwPZdSfFKIvxKVgWxvruz7OiFtiEgeRZ33uU+fiw9aoKWZn/9K4q
         MGxUdqn1ScqTzCk5rf+3hOIvkih4aGScq/w6az1w=
Date:   Mon, 5 Aug 2019 15:18:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, lorenzo.bianconi@redhat.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: imu: st_lsm6dsx: inline output acc/gyro
 output regs
Message-ID: <20190805151845.44576afa@archlinux>
In-Reply-To: <b6562850-0067-378a-572d-368de04221ac@puri.sm>
References: <cover.1564427804.git.lorenzo@kernel.org>
        <930dffcdf5fa9c398c34a3c25a39e65fbd8ae836.1564427804.git.lorenzo@kernel.org>
        <b6562850-0067-378a-572d-368de04221ac@puri.sm>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2 Aug 2019 07:35:46 +0200
Martin Kepplinger <martin.kepplinger@puri.sm> wrote:

> On 29.07.19 21:22, Lorenzo Bianconi wrote:
> > Remove output register definition and inline register value since
> > they are used only for iio channel definition. This is a preliminary
> > patch to add support for LSM9DS1 sensor to st_lsm6dsx driver
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 26 +++++---------------
> >  1 file changed, 6 insertions(+), 20 deletions(-)
> >   
> 
> thanks. I'm running this patchset now and will resend LSM9DS1 patches
> after these are merged.
> 
> Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> 

Nice little tidy up. Applied.

Thanks,

Jonathan
