Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3292D5550
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 10:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfJMIVc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 04:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbfJMIVc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 04:21:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2CC6206A3
        for <linux-iio@vger.kernel.org>; Sun, 13 Oct 2019 08:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570954892;
        bh=61d/Q41SdPJUgW0JO4GIAqHbF6d3o8AkapbfXrmXSn0=;
        h=Date:From:To:Subject:From;
        b=UodRSNzzv8+Dj9NNIRzBM+cTCI+AB/ykSLtsDZOZVqljVK2lw2gNMXLfK4VDfs86c
         iSs0izOOUW6rDjkySnalm/CBXl6qIfeWhCnyItqA9JxX7J8oe/nBvoEs14FgvFWgdI
         +NbgotDQTIjC4DW5dL96A/70A8WbdzrphbnmdQDI=
Date:   Sun, 13 Oct 2019 09:21:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Subject: Note IIO togreg branch rebased.
Message-ID: <20191013092128.6ca0f756@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

I normally try to avoid doing this, but unfortunately needed to
drop a series from the pull request I just sent out.

This may cause anyone who was based on top of the togreg branch
to have to manually reapply their local patches.

Sorry about that,

Jonathan
