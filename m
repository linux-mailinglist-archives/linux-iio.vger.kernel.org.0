Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047BB2F8E51
	for <lists+linux-iio@lfdr.de>; Sat, 16 Jan 2021 18:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbhAPRdt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Jan 2021 12:33:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbhAPRdt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Jan 2021 12:33:49 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED6D822AAF;
        Sat, 16 Jan 2021 17:33:08 +0000 (UTC)
Date:   Sat, 16 Jan 2021 17:33:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] iio: dac: ad5766: add driver support for AD5766
Message-ID: <20210116173307.3d359221@archlinux>
In-Reply-To: <20210115112105.58652-3-cristian.pop@analog.com>
References: <20210115112105.58652-1-cristian.pop@analog.com>
        <20210115112105.58652-3-cristian.pop@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Jan 2021 13:21:05 +0200
Cristian Pop <cristian.pop@analog.com> wrote:

> The AD5766/AD5767 are 16-channel, 16-bit/12-bit, voltage output dense DACs
> Digital-to-Analog converters.
> 
> This change adds support for these DACs.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
Series applied to the togreg branch of iio.git and pushed out as testing for
autobuilders to work their magic and see if they can find anything we missed.


Thanks,

Jonathan
