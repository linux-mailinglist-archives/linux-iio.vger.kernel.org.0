Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C1843061B
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 03:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244910AbhJQB6n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Oct 2021 21:58:43 -0400
Received: from vern.gendns.com ([98.142.107.122]:48362 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244849AbhJQB6j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Oct 2021 21:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oy8DSyGv+jeXmkM7TMu2S60qW6NEmMHEMDkXehA/CE0=; b=WTTXdJZS9XL/KWAAhX67Grq0kU
        ObLxbh9xN+katVJXZd+mBXCWYAKdxV15H5mn5wq8dyP93QKbPgvUrtll6P5zu1LfAgruWoBwacDew
        NbbeoYmTzdD/o9SgeRXl00oalUbhtgmE09ujq4T+xja+zDZjZY4Utdn85sM61EEAOl0OIiXbgu0F9
        gjsvtFnjYB9Wy3VUTWhvFYEiY7HaQwaysWMQnPN1lhIyEvfv6R85ysu8Nq/8nqpmQgxcsHrJEzopH
        iYT3cq6a1C4LMV0IP5wTcOAsx0iUN2z5yg+FeezsHZnE0ybp7BmwclNEgltjaMqJ0+1iVkaGgQaqn
        hlixPg9g==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:41624 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mbv43-0004D2-KJ; Sat, 16 Oct 2021 21:34:17 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] counter: ti-eqep: implement features for speed measurement
Date:   Sat, 16 Oct 2021 20:33:35 -0500
Message-Id: <20211017013343.3385923-1-david@lechnology.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Now that the counter subsystem has a new chrdev for events, we can use this to
add new features to the TI eQEP driver to be able to do accurate speed
measurement.

This adds two new device-level components, a Unit Timer and an Edge Capture
Unit. I don't have much knowledge about other available counter hardware, so
I don't know if it makes sense to try to make these more generic, e.g.
counterX/timerY/* and counterX/captureY/*. For now, they are just flat
(counterX/unit_timer_* and counterX/edge_capture_unit_*) and assume there is
only one instance per counter device.

This has been tested on a BeagleBone Blue with LEGO MINDSTORMS motors.

David Lechner (8):
  counter/ti-eqep: implement over/underflow events
  counter/ti-eqep: add support for direction
  counter/ti-eqep: add support for unit timer
  docs: counter: add unit timer sysfs attributes
  counter/ti-eqep: add support for latched position
  docs: counter: add latch_mode and latched_count sysfs attributes
  counter/ti-eqep: add support for edge capture unit
  docs: counter: add edge_capture_unit_* attributes

 Documentation/ABI/testing/sysfs-bus-counter | 100 +++-
 drivers/counter/ti-eqep.c                   | 482 +++++++++++++++++++-
 include/uapi/linux/counter.h                |   4 +
 3 files changed, 575 insertions(+), 11 deletions(-)

-- 
2.25.1

