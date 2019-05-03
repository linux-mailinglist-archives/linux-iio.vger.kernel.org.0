Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775BC12BE3
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2019 12:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfECKy6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 06:54:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45990 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfECKy6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 06:54:58 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e34:ee7d:73d0:5796:7015:7f6:aeeb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 07775263955;
        Fri,  3 May 2019 11:54:56 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
To:     linux-iio@vger.kernel.org
Cc:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Subject: [RFC 0/1] Add new sysfs ABI for chromebook devices
Date:   Fri,  3 May 2019 12:54:45 +0200
Message-Id: <cover.1556873525.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Chromebooks embedded controller (EC) provides new field in the 3rd version of 
its protocol. Those values need to be exposed as sysfs entries.

Minimum and maximum frequencies may probably be a standard iio ABI.
There is an existing ABI (sampling_frequency_available) but only for discrete 
set of values.
We have different possible solution and I want to ask interested people for the 
best one:
1. we keep the ABI proposed in this RFC (in the chromebook specific code)
2. we move min and max freq as 2 different standard ABI
3. we add a new standard iio ABI to set a range (sampling_frequency_range)
4. we change the 'sampling_frequency_available' ABI to return discrete values 
like '2 4 6 8' or a range like '[2 - 8]'
5. the solution I didn't think about

Thanks

Gwendal Grignou (1):
  iio: common: cros_ec_sensors: add extra sensor API

 .../ABI/testing/sysfs-bus-iio-cros-ec         |  24 ++++
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 126 +++++++++++++++++-
 .../linux/iio/common/cros_ec_sensors_core.h   |   7 +
 include/linux/mfd/cros_ec_commands.h          |  21 +++
 4 files changed, 177 insertions(+), 1 deletion(-)

-- 
2.19.2

