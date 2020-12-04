Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313572CE7FA
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 07:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgLDGVM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Dec 2020 01:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgLDGVM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Dec 2020 01:21:12 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543F3C061A4F;
        Thu,  3 Dec 2020 22:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=fgXm/QAA7Eu/vUF3KYHNBDk79AWBS+9/y2XhJwrc8oI=; b=adqeUg3D1GdG42zq/UAYkgzhs4
        UnCqGFnejT70aau0EBTdgsSd1ddEjRk67AAxhcs/b01fBSJcbpZ5Db4za4F8wSlugFicfVcF5N3Il
        eWmZCOzmN6pC1E46W8aQ+go8JeZypUdb/6RhJOu6PJDbbH0YS8p925Gntv+U04hUWD1ocW+je2Cir
        Kn9IUeK6vW1JRCB2SCqR5rVFMAvn3xVzWc5AS6BmXfs/ucwDLrtzeUwPnFl/1qM2hM1cKUlg/QnMH
        qE6ZBo0gmGQR02PeN71y10m5eiCRmTTY/ok32vlCYkV+4BT/I95A07GITG20r+PU68N2B7CKsZPLM
        o3UKTiJg==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kl4SD-0002HZ-Fv; Fri, 04 Dec 2020 06:20:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 0/8] Documentation: HID: edit/correct all files
Date:   Thu,  3 Dec 2020 22:20:14 -0800
Message-Id: <20201204062022.5095-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make editing corrections to all files in Documentation/hid/.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org

 [PATCH 1/8] Documentation: HID: hid-alps editing & corrections
 [PATCH 2/8] Documentation: HID: amd-sfh-hid editing & corrections
 [PATCH 3/8] Documentation: HID: hiddev editing & corrections
 [PATCH 4/8] Documentation: HID: intel-ish-hid editing & corrections
 [PATCH 5/8] Documentation: HID: hidraw editing & corrections
 [PATCH 6/8] Documentation: HID: hid-sensor editing & corrections
 [PATCH 7/8] Documentation: HID: hid-transport editing & corrections
 [PATCH 8/8] Documentation: HID: uhid editing & corrections

 Documentation/hid/amd-sfh-hid.rst   |   16 ++---
 Documentation/hid/hid-alps.rst      |    4 -
 Documentation/hid/hid-sensor.rst    |   18 +++---
 Documentation/hid/hid-transport.rst |   12 ++--
 Documentation/hid/hiddev.rst        |   12 ++--
 Documentation/hid/hidraw.rst        |    5 +
 Documentation/hid/intel-ish-hid.rst |   74 +++++++++++++-------------
 Documentation/hid/uhid.rst          |   34 +++++------
 8 files changed, 89 insertions(+), 86 deletions(-)
