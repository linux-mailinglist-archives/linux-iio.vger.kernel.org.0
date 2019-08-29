Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD65A20E9
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2019 18:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfH2Qaq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Aug 2019 12:30:46 -0400
Received: from ox4u.de ([212.118.221.216]:58278 "EHLO s1.ox4u.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbfH2Qaq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Aug 2019 12:30:46 -0400
Received: by s1.ox4u.de (Postfix, from userid 65534)
        id 9DFF8260171; Thu, 29 Aug 2019 18:30:44 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on s1.ox4u.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
        autolearn=disabled version=3.4.1
Received: from ws-140106.localnet (unknown [212.185.67.146])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by s1.ox4u.de (Postfix) with ESMTPSA id 7A9BB26016E
        for <linux-iio@vger.kernel.org>; Thu, 29 Aug 2019 18:30:44 +0200 (CEST)
From:   Alexander Stein <alexander.stein@systec-electronic.com>
To:     linux-iio@vger.kernel.org
Subject: read_raw endianess
Date:   Thu, 29 Aug 2019 18:30:43 +0200
Message-ID: <3056697.yunu66HNpL@ws-140106>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

I'm wondering which endianess read_raw shall be returned? E.g. when calling
> cat /sys/bus/iio/devices/iio\:device2/in_voltage0_raw
How much 'rawness' shall be returned? How shall i return my 14 Bit
big-endian left-adjusted value stored in 16bits?

Best regards,
Alexander



