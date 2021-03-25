Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E70349A18
	for <lists+linux-iio@lfdr.de>; Thu, 25 Mar 2021 20:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhCYTTI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 15:19:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhCYTSx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Mar 2021 15:18:53 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 456B1619CB
        for <linux-iio@vger.kernel.org>; Thu, 25 Mar 2021 19:18:52 +0000 (UTC)
Date:   Thu, 25 Mar 2021 19:18:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Subject: iio togreg branch rebase.
Message-ID: <20210325191855.5bfdf0e3@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

Unfortunately the mess I made of building the immutable branch earlier
in this cycle to deal with the SCMI driver meant I'd missed some
fixes tags that needed updating.

Anyhow, upshot is I only realised during last minute tests before
a pull request.   Had to rebase to fix, so apologies to anyone who
happened to be basing their trees on IIO.

No actual code changes, but the history will be different.

I need to redo the SCMI IB merge on top, but for now the togreg
branch should be good again.

It's likely any fixes in flight for stuff this cycle will need
their tags updating, but hopefully I'll spot them this time!

Thanks,

Jonathan
