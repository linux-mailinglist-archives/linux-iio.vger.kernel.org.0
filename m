Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D13311290B
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2019 11:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfLDKMP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Dec 2019 05:12:15 -0500
Received: from mx07-002cda01.pphosted.com ([185.132.180.122]:37658 "EHLO
        mx07-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727273AbfLDKMO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Dec 2019 05:12:14 -0500
Received: from pps.filterd (m0135535.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4A28pa015092;
        Wed, 4 Dec 2019 10:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=08102019;
 bh=mS6AQzbCYdh4A0907BPnrDZotvbATb2HVB0NVOUsCIg=;
 b=K+K2oQcsvWPRmakJrRYBhAadRDG59HVzY6XC//2WFyGr5doYAzzRy47g3th+IU0w9ji2
 qy8EmIVXNGbwR5YsLcMFT7mF9rZZKzXisfBduqq2uqf3bhq9PtUDIusnPIQ8ebbgPlqj
 YnJ2qpbdI4VxSuBz8nYsNARhS5POoEVnunR6N5IAtBlAg5e4s2vyaP4/OywzylOHMGQi
 18UvII8klspM/7r7qY5Or+WxCaTyBTvDKsxCdExqnDU3jqAvqjcmLK3Hli67DTWFdits
 NuK/1YwvEF9wdUe7g7af10bvlPnphCagaOhCFxUru0Dxlz7p+JtGD0V3VUD9E/0GlGYl Cw== 
Received: from atgrzso2833.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 2wnja3thf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 10:03:56 +0000
Received: from pps.filterd (atgrzso2833.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso2833.avl01.avlcorp.lan (8.16.0.27/8.16.0.27) with SMTP id xB49xHjV028811;
        Wed, 4 Dec 2019 11:03:55 +0100
Received: from atgrzsw1696.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso2833.avl01.avlcorp.lan with ESMTP id 2wkh0psxe5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 11:03:55 +0100
Received: from atgrzsw1696.avl01.avlcorp.lan (10.12.64.164) by
 atgrzsw1696.avl01.avlcorp.lan (10.12.64.164) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 4 Dec 2019 11:03:54 +0100
Received: from ATGRZWN210214.avl01.avlcorp.lan (10.12.100.12) by
 atgrzsw1696.avl01.avlcorp.lan (10.12.64.164) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 4 Dec 2019 11:03:54 +0100
From:   <tomislav.denis@avl.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tomislav.denis@avl.com>
Subject: [PATCH v3 0/3] Add support for DLH pressure sensors
Date:   Wed, 4 Dec 2019 11:03:51 +0100
Message-ID: <20191204100354.16652-1-tomislav.denis@avl.com>
X-Mailer: git-send-email 2.10.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: f9e74532-fb7d-4806-8539-2b9574eafa9a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-04_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=939
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912040077
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 clxscore=1015 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040077
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tomislav Denis <tomislav.denis@avl.com>

This patchset adds support for All Sensors DLH series low
voltage digital pressure sensors.

Datasheet: https://www.allsensors.com/cad/DS-0355_Rev_B.PDF

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
  bindings: iio: pressure: Add dlh-i2c documentation

 .../bindings/iio/pressure/asc,dlh-i2c.yaml         |  51 +++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   8 +
 drivers/iio/pressure/Kconfig                       |  12 +
 drivers/iio/pressure/Makefile                      |   1 +
 drivers/iio/pressure/dlh-i2c.c                     | 375 +++++++++++++++++++++
 6 files changed, 449 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/asc,dlh-i2c.yaml
 create mode 100644 drivers/iio/pressure/dlh-i2c.c

-- 
2.7.4

