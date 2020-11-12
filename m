Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0022B082A
	for <lists+linux-iio@lfdr.de>; Thu, 12 Nov 2020 16:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgKLPMF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Nov 2020 10:12:05 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:63330 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727035AbgKLPMF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Nov 2020 10:12:05 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACExRZD014706;
        Thu, 12 Nov 2020 10:11:48 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34npab1v4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 10:11:48 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0ACFBkjf006265
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 12 Nov 2020 10:11:47 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 12 Nov 2020 07:11:45 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 12 Nov 2020 07:10:26 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 12 Nov 2020 07:11:45 -0800
Received: from nsa.sphairon.box ([10.44.3.53])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0ACFBhCd018749;
        Thu, 12 Nov 2020 10:11:44 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [RFC PATCH 0/1] Sanity check buffer callback
Date:   Thu, 12 Nov 2020 16:13:33 +0100
Message-ID: <20201112151334.32167-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_06:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxlogscore=616 clxscore=1015 lowpriorityscore=0
 suspectscore=1 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120091
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When going through the code of the buffer-cb interface and all it's
users, I realized that the stm32_adfsdm driver is calling
`iio_channel_get_all_cb()` with NULL for the cb. After going a bit
trough the stm drivers, it looks like this is actually intentional.
However, it is clear that we have a clear/direct route here for a NULL
pointer dereference. I'm being lazy in this RFC and just doing a
sanity check in the `iio_buffer_cb_store_to()` so that we don't have to
change the stm driver... The point is just to bring this up and see if
we want to do something about this.

To be clear, the way I think this should go is just to return -EINVAL in
`iio_channel_get_all_cb()` if a NULL ptr is passed. Whats the point of a
buffer-cb if cb is NULL, right? This would naturally break the stm
driver, but I guess we could just define a dummy handler there that
would not be used (or could the HW consumer be an option here?)...

Thoughts?

Nuno Sá (1):
  iio: buffer: Sanity check buffer callback

 drivers/iio/buffer/industrialio-buffer-cb.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.29.2

