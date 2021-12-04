Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C134685D5
	for <lists+linux-iio@lfdr.de>; Sat,  4 Dec 2021 16:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242841AbhLDPKg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Dec 2021 10:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241868AbhLDPKf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 10:10:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46341C061751;
        Sat,  4 Dec 2021 07:07:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66462B80CF8;
        Sat,  4 Dec 2021 15:07:08 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 94B6BC341C0;
        Sat,  4 Dec 2021 15:07:04 +0000 (UTC)
Date:   Sat, 4 Dec 2021 15:12:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        mario.tesi@st.com
Subject: Re: [PATCH v2 2/2] Documentation: dt: iio: st_lsm6dsx: add
 disable-sensor-hub property
Message-ID: <20211204151206.03ddb84b@jic23-huawei>
In-Reply-To: <YaVFeYsGYVOBS65b@robh.at.kernel.org>
References: <cover.1636816719.git.lorenzo@kernel.org>
        <54287a93922ac839501b776d288cc368aa81f0ab.1636816719.git.lorenzo@kernel.org>
        <YaVFeYsGYVOBS65b@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Nov 2021 15:26:17 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, 13 Nov 2021 16:23:15 +0100, Lorenzo Bianconi wrote:
> > Enable/disable internal i2c controller slave autoprobing at bootstrap.
> > Disable sensor-hub is useful if i2c controller clock/data lines are
> > connected through a pull-up with other chip lines (e.g. SDO/SA0).
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Series applied to the togreg branch of iio.git

Thanks,

Jonathan
