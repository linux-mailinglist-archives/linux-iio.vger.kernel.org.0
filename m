Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4E7FC433
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2019 11:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfKNKao (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Nov 2019 05:30:44 -0500
Received: from mx08-002cda01.pphosted.com ([185.183.28.84]:15490 "EHLO
        mx08-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbfKNKao (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Nov 2019 05:30:44 -0500
Received: from pps.filterd (m0135533.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAEA9Acp032465;
        Thu, 14 Nov 2019 10:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=08102019;
 bh=TefWMD6rRoX5VUE97XIMfnlVOo2CqQDgySSkkPaoFEs=;
 b=hl/TMdxqVlQmAI7fQFBC2ofi+vSLkK9hZxN55EGzY9DNN2omRZNBK3cu6lXfNAa+alzw
 dYNnbA9zkXF39ntchn02cffq4qcYHYQUpTiHZ4fawLqsmI6sHSOXmERVXG9buRSrqsPt
 Ub34XohQ1+1vuv48IfSifZT1P/Io7j+Xb2hPKZImXxZqoknhrab5f2DDdytK/wRWBQ60
 veb43j8E8aisLuioCJT5vYSgtXfHlj+NcF4kOMfOLoHFR5wMTvGMwlI9ESyJ4Tk35c4V
 u/P+LlggJIfGzcRd3Zv6MnrsIhryC9mraXHjAPnxtWKa1INYsGetKwRhqRlkJfne8o8T jQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=19122018;
 bh=TefWMD6rRoX5VUE97XIMfnlVOo2CqQDgySSkkPaoFEs=;
 b=joX2MjKL/jrl8lEChfHH+tZsksLof9MG3i8CGNjsumlRfbl5CPxDeQ4DoKIYS9Btt41C
 JIr3TNsz+JRHJZxwgVmV3vUZxHCq2urs9T+mC5BT5V0RyQSaLbK4r8fhG+n1Xvax40nh
 ovWuoh8fzQSsKcJInrbYHpv6w3zcWt9P1Ye+O1esVMp8jxx03o4WaHS0qCaRVB0Ib73C
 KX58+/AnP3S7HWui94/zW7GvyMxtHT0Mc1Ffj7YBLHjfn4PCW1l3UE9pk5hJtwzbL4wL
 8ibxpkXWbXld/jx4ZgqxPLACNfXmbfAqOiPxkueD0LGPltaC9YjeMnch1xzEVJV6qB0K pw== 
Received: from atgrzso8132.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 2w5p88a23x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 10:09:10 +0000
Received: from pps.filterd (atgrzso8132.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso8132.avl01.avlcorp.lan (8.16.0.27/8.16.0.27) with SMTP id xAEA99ud026403;
        Thu, 14 Nov 2019 11:09:09 +0100
Received: from atgrzsw1691.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso8132.avl01.avlcorp.lan with ESMTP id 2w93df82wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 11:09:09 +0100
Received: from atgrzsw1696.avl01.avlcorp.lan (10.12.64.164) by
 ATGRZSW1691.avl01.avlcorp.lan (10.12.64.112) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 Nov 2019 11:09:09 +0100
Received: from ATGRZWN210080.avl01.avlcorp.lan (10.12.100.12) by
 atgrzsw1696.avl01.avlcorp.lan (10.12.64.164) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 14 Nov 2019 11:09:09 +0100
From:   <tomislav.denis@avl.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tomislav.denis@avl.com>
Subject: [PATCH 0/3] Add support for DLH pressure sensors 
Date:   Thu, 14 Nov 2019 11:09:05 +0100
Message-ID: <20191114100908.11180-1-tomislav.denis@avl.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: f9e74532-fb7d-4806-8539-2b9574eafa9a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-14_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=733
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911140094
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-14_01:2019-11-14,2019-11-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=798 lowpriorityscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911140094
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tomislav Denis <tomislav.denis@avl.com>

This patchset adds support for All Sensors DLH series low
voltage digital pressure sensors.

Datasheet: https://www.allsensors.com/cad/DS-0355_Rev_B.PDF

Tomislav Denis (3):
  iio: pressure: Add driver for DLH pressure sensors
  dt-bindings: Add asc vendor
  bindings: iio: pressure: Add dlh-i2c documentation

 .../devicetree/bindings/iio/pressure/dlh-i2c.yaml  |  43 +++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   8 +
 drivers/iio/pressure/Kconfig                       |  12 +
 drivers/iio/pressure/Makefile                      |   1 +
 drivers/iio/pressure/dlh-i2c.c                     | 322 +++++++++++++++++++++
 6 files changed, 388 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/dlh-i2c.yaml
 create mode 100644 drivers/iio/pressure/dlh-i2c.c

-- 
2.7.4

