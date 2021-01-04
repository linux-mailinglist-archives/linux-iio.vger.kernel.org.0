Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC1B2E93BD
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jan 2021 11:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbhADKwm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jan 2021 05:52:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:56158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbhADKwm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 4 Jan 2021 05:52:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28DC921E92;
        Mon,  4 Jan 2021 10:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609757521;
        bh=yCS/H6aJTt1wzx9x4HeCFHymxrj9yPku3Xzccp3e8O8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=f7iIoLIoGBUmEY8KBSNAMkcLrUee3scGwOGiZarB5Y2vpEDflGLaclao7k1/6fMax
         c3CDxaf2Ry92mPb53JZtNWsZB5rdikA0xiRjIuIFaZ5cYSsn5P3TCX1KRd4bukCJ4j
         jGTCaEBavYbslgWDujZ12UZiNsmYhRjaWPRcahy5xg5gTnsK6WvjcGXEWHm0APKvRI
         v2fXQChImr2/Hcgs/dU/KxtJcx9im7+1GTjCxDyX/ZZ3IFnyWt8w5MHDiG1oWUueUz
         Q1YuI0sr/qN9ttjeuurQCFC+22d3GZ7VEN0nK4qZk8UPYeea0lMMPyoCd1cZ4LaAaR
         mZiVwJiXkVaYQ==
Date:   Mon, 4 Jan 2021 11:51:51 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Documentation: HID: edit/correct all files
In-Reply-To: <20201228205327.1063-1-rdunlap@infradead.org>
Message-ID: <nycvar.YFH.7.76.2101041151400.13752@cbobk.fhfr.pm>
References: <20201228205327.1063-1-rdunlap@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Dec 2020, Randy Dunlap wrote:

> Make editing corrections to all files in Documentation/hid/.
> 
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: linux-iio@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> 
>  [PATCH v2 1/8] Documentation: HID: hid-alps editing & corrections
>  [PATCH v2 2/8] Documentation: HID: amd-sfh-hid editing & corrections
>  [PATCH v2 3/8] Documentation: HID: hiddev editing & corrections
>  [PATCH v2 4/8] Documentation: HID: intel-ish-hid editing & corrections
>  [PATCH v2 5/8] Documentation: HID: hidraw editing & corrections
>  [PATCH v2 6/8] Documentation: HID: hid-sensor editing & corrections
>  [PATCH v2 7/8] Documentation: HID: hid-transport editing & corrections
>  [PATCH v2 8/8] Documentation: HID: uhid editing & corrections
> 
>  Documentation/hid/amd-sfh-hid.rst   |   22 +++----
>  Documentation/hid/hid-alps.rst      |    4 -
>  Documentation/hid/hid-sensor.rst    |   18 +++---
>  Documentation/hid/hid-transport.rst |   12 ++--
>  Documentation/hid/hiddev.rst        |   10 +--
>  Documentation/hid/hidraw.rst        |    5 +
>  Documentation/hid/intel-ish-hid.rst |   78 +++++++++++++-------------
>  Documentation/hid/uhid.rst          |   34 +++++------
>  8 files changed, 93 insertions(+), 90 deletions(-)

Queued in hid.git#for-5.12/doc. Thanks,

-- 
Jiri Kosina
SUSE Labs

