Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB2A10D21E
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2019 08:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfK2H6n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Nov 2019 02:58:43 -0500
Received: from mx08-002cda01.pphosted.com ([185.183.28.84]:2752 "EHLO
        mx08-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726215AbfK2H6n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Nov 2019 02:58:43 -0500
X-Greylist: delayed 1456 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Nov 2019 02:58:41 EST
Received: from pps.filterd (m0135533.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAT7Uftf016662;
        Fri, 29 Nov 2019 07:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=08102019; bh=mndJQ/smTIpFZ71UHwUCS1vIUg3W7qYyZzfvdix2fEk=;
 b=EJipJv71BWhIUjnpgufb0OLEc+TpjdS83bHzdnVqu7F/4nBfej8J0hIMwsCvgAv7ZZK9
 6mVsVjb9I14RwMbf1r8IQ3THhCOwCtsKrZY6HwbWf77imc+sbnoEzr3bC9boQkryTTUI
 EfTOy8FCmJlVxokT4AUFXEES9SZS9930Ogh+MTjmOVzQy/Epq0KRu+h42jXwiJkkeg8z
 9M11AMTUbGVkg5SRLKBj6pAZN2KfcUeCgvTbx78GbDV1I3bBlCqxe8DoUEiL7omWfXtB
 LfrnYd+3PUhRdz8z1U0pqJB8SPJePXG1kjXf+0dEYznwlv9W1fMugZJhTfGGPHLaulpG Nw== 
Received: from atgrzso2901.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 2whd0gw05a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Nov 2019 07:34:21 +0000
Received: from pps.filterd (atgrzso2901.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso2901.avl01.avlcorp.lan (8.16.0.27/8.16.0.27) with SMTP id xAT7TtSL013085;
        Fri, 29 Nov 2019 08:34:21 +0100
Received: from atgrzsw1695.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso2901.avl01.avlcorp.lan with ESMTP id 2wewbptvf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 29 Nov 2019 08:34:21 +0100
Received: from atgrzsw3272.avl01.avlcorp.lan (10.12.65.158) by
 atgrzsw1695.avl01.avlcorp.lan (10.12.64.163) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 29 Nov 2019 08:34:20 +0100
Received: from ATGRZSW1694.avl01.avlcorp.lan (10.12.64.115) by
 atgrzsw3272.avl01.avlcorp.lan (10.12.65.158) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 29 Nov 2019 08:34:20 +0100
Received: from ATGRZWN210080.avl01.avlcorp.lan (10.12.100.12) by
 ATGRZSW1694.avl01.avlcorp.lan (10.12.64.115) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 29 Nov 2019 08:34:20 +0100
From:   <tomislav.denis@avl.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tomislav.denis@avl.com>
Subject: [PATCH v2 0/3] Add support for DLH pressure sensors
Date:   Fri, 29 Nov 2019 08:34:17 +0100
Message-ID: <20191129073420.9800-1-tomislav.denis@avl.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20191114100908.11180-1-tomislav.denis@avl.com>
References: <20191114100908.11180-1-tomislav.denis@avl.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: f9e74532-fb7d-4806-8539-2b9574eafa9a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-29_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=882
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911290063
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_01:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911290064
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tomislav Denis <tomislav.denis@avl.com>

This patchset adds support for All Sensors DLH series low
voltage digital pressure sensors.

Datasheet: https://www.allsensors.com/cad/DS-0355_Rev_B.PDF

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
 drivers/iio/pressure/dlh-i2c.c                     | 429 +++++++++++++++++++++
 6 files changed, 503 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/asc,dlh-i2c.yaml
 create mode 100644 drivers/iio/pressure/dlh-i2c.c

-- 
2.7.4

