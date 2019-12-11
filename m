Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 226D511A8A5
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 11:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfLKKMA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 05:12:00 -0500
Received: from mx07-002cda01.pphosted.com ([185.132.180.122]:46193 "EHLO
        mx07-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727829AbfLKKMA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 05:12:00 -0500
X-Greylist: delayed 726 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Dec 2019 05:11:57 EST
Received: from pps.filterd (m0135534.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBB9tvKU009950;
        Wed, 11 Dec 2019 09:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=08102019;
 bh=9ZyHZUPN7z4Trra14S3zV/8/hl7XyA/SF/Uv/GnbFJM=;
 b=W3gGA+91uu58Rau9KdI7muM1GxwpioumEjOIT5BwCm8uLXNzcfLpY4VEr+wMYrJLkL0h
 e2lNVqVK/VldrHdLAB5gOxnGLhoY7OdyN42FjYM+1wvRzTgNEmx3iUGlLiJK0Q2oBXrU
 z4Ze3YTmjHBrpyJpZHgWRtstrxW2oL5UZPcsRkULv+YdEwCcxayCbSNJuJnXv+QNzYMH
 bKIpZoLA3S4Gvahx6Tej/VkUQQRY+xYPBa3PmYjD0Dib8+y/Lm93ydu/SAc4CpcElKby
 DwnAvBluUkPm8kuNsI8+7BPBbBGhLIYyZ+XajOoxBqOLNaxp+6qDmV0Lg/42L8y5ocHz Ag== 
Received: from atgrzso8133.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 2wr2ac70bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 09:59:48 +0000
Received: from pps.filterd (atgrzso8133.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso8133.avl01.avlcorp.lan (8.16.0.27/8.16.0.27) with SMTP id xBB7mf7v026664;
        Wed, 11 Dec 2019 10:59:47 +0100
Received: from atgrzsw1695.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso8133.avl01.avlcorp.lan with ESMTP id 2wr3hmsyve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 10:59:47 +0100
Received: from ATGRZSW1694.avl01.avlcorp.lan (10.12.64.115) by
 atgrzsw1695.avl01.avlcorp.lan (10.12.64.163) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Dec 2019 10:59:47 +0100
Received: from ATGRZWN210214.avl01.avlcorp.lan (10.12.100.12) by
 ATGRZSW1694.avl01.avlcorp.lan (10.12.64.115) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 11 Dec 2019 10:59:47 +0100
From:   <tomislav.denis@avl.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tomislav.denis@avl.com>
Subject: [PATCH v4 0/3] Add support for DLH pressure sensors
Date:   Wed, 11 Dec 2019 10:59:43 +0100
Message-ID: <20191211095946.7904-1-tomislav.denis@avl.com>
X-Mailer: git-send-email 2.10.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: f9e74532-fb7d-4806-8539-2b9574eafa9a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=899
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912110062
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_02:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110086
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tomislav Denis <tomislav.denis@avl.com>

This patchset adds support for All Sensors DLH series low
voltage digital pressure sensors.

Datasheet: https://www.allsensors.com/cad/DS-0355_Rev_B.PDF

Changes in v4:
- unused includes removed
- fixed casting from big endian to cpu endian
- removed -i2c from all filenames
- removed _i2c from driver name and all functions 

Changes in v3:
- missing ack included in the commit message
- unneceseary iio_buffer_enabled check removed
- data ready trigger removed
- trigger handler and read raw functions refactored

Changes in v2:
- web page link in the MAINTAINERS file fixed
- adjust the units of the output to the IIO ABI
- unneceseary default case removed
- define the channel member of the iio_chan_spec
  struct for channels specification
- remove explicit cast for pointers of type void *
- add support for the EOC(data ready) pin
- drop the unneceseary return ret;
- rename dlh-i2c.yaml to asc,dlh-i2c.yaml
- change the bindings copyright to GPL-2.0-only OR BSD-2-Clause
- document EOC(data ready) pin

Tomislav Denis (3):
  iio: pressure: Add driver for DLH pressure sensors
  dt-bindings: Add asc vendor
  bindings: iio: pressure: Add documentation for dlh driver

 .../devicetree/bindings/iio/pressure/asc,dlh.yaml  |  51 +++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   8 +
 drivers/iio/pressure/Kconfig                       |  12 +
 drivers/iio/pressure/Makefile                      |   1 +
 drivers/iio/pressure/dlh.c                         | 375 +++++++++++++++++++++
 6 files changed, 449 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/asc,dlh.yaml
 create mode 100644 drivers/iio/pressure/dlh.c

-- 
2.7.4

