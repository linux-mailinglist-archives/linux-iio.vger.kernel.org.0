Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BBF481E9F
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 18:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhL3RbD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 12:31:03 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58074 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhL3RbC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 12:31:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0854ACE1C36
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:31:01 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 15D83C36AE7
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:30:57 +0000 (UTC)
Date:   Thu, 30 Dec 2021 17:36:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Subject: IIO tree closed for new stuff for 5.17.
Message-ID: <20211230173639.578663b6@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all,

As the 5.17b pull request stated, I've taken a somewhat
conservative view of patches that came in very close to or during
the holidays that affect some IIO reviewers and contributors.

Anyhow, anything other than fixes will now being 5.18 material.
As such I've been a bit slow replying to some patch series and will catch up
with outstanding stuff before the merge window closes.

There are some fixes already on the list, and I'll look to gather
those up for a pull just after rc1.

Thanks and Happy New Year.

Jonathan
