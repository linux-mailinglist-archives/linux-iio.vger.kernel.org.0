Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFFC2E6B9D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 00:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbgL1Wzy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Dec 2020 17:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbgL1UyS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Dec 2020 15:54:18 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677CDC0613D6;
        Mon, 28 Dec 2020 12:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=v09Nc7+APqPjSs0d+VhDDcdKOvqlpFdSna4lZxnE79c=; b=C4h8jv0NQBbAdGq4GtSw7fQC0Q
        krlUD94moocoN71JdNZgiOdOoDbMQxtdyJbyFM+9IYDQ3WcHLrgHtyAb3pZC/FmfxLRdCfybrt/Zj
        F+hJyNzh5iDMjzZcm/1z4mqpsjjtqngdNqwcpvj8DLHorf5gvOD5p6lzG9eWqNqWJBz17PDMPsNt/
        vQilrUCWxvNAlLlbIaSZRer2DhOTe3FAXWcrQX9ZCT9N8xRTxKTQErG5DhMtUNtu00tig/ak6xdcg
        /5brB4XSaSF9rLgVomfwIFpA/YCSvrZTOPB716cIEBJIVXh9HVPtlxscVhp3aQyTlNsFzC3sjh8M1
        wVchFCPA==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ktzWJ-0002ml-9z; Mon, 28 Dec 2020 20:53:35 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 0/8] Documentation: HID: edit/correct all files
Date:   Mon, 28 Dec 2020 12:53:19 -0800
Message-Id: <20201228205327.1063-1-rdunlap@infradead.org>
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

 [PATCH v2 1/8] Documentation: HID: hid-alps editing & corrections
 [PATCH v2 2/8] Documentation: HID: amd-sfh-hid editing & corrections
 [PATCH v2 3/8] Documentation: HID: hiddev editing & corrections
 [PATCH v2 4/8] Documentation: HID: intel-ish-hid editing & corrections
 [PATCH v2 5/8] Documentation: HID: hidraw editing & corrections
 [PATCH v2 6/8] Documentation: HID: hid-sensor editing & corrections
 [PATCH v2 7/8] Documentation: HID: hid-transport editing & corrections
 [PATCH v2 8/8] Documentation: HID: uhid editing & corrections

 Documentation/hid/amd-sfh-hid.rst   |   22 +++----
 Documentation/hid/hid-alps.rst      |    4 -
 Documentation/hid/hid-sensor.rst    |   18 +++---
 Documentation/hid/hid-transport.rst |   12 ++--
 Documentation/hid/hiddev.rst        |   10 +--
 Documentation/hid/hidraw.rst        |    5 +
 Documentation/hid/intel-ish-hid.rst |   78 +++++++++++++-------------
 Documentation/hid/uhid.rst          |   34 +++++------
 8 files changed, 93 insertions(+), 90 deletions(-)
