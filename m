Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1233A7B96AE
	for <lists+linux-iio@lfdr.de>; Wed,  4 Oct 2023 23:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244144AbjJDVu6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Oct 2023 17:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244099AbjJDVuz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Oct 2023 17:50:55 -0400
Received: from qs51p00im-qukt01071902.me.com (qs51p00im-qukt01071902.me.com [17.57.155.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BBDC1
        for <linux-iio@vger.kernel.org>; Wed,  4 Oct 2023 14:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1696456247;
        bh=Hbw27RqrnkmZsouexnsyZjMFcBnI4MG8WYB6dVJNrA8=;
        h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:To;
        b=N159VIWYZjQuGOxalUHhdvmC/4Fq2XfO/w2iMhuTH4oq9FT/NrKVFxJ+tzcifYj0h
         1sremY7hQdihiGRHvRRprr/nxOYGUm6ksn3pg64jess5QEXPgU1socEZnfGXM4br63
         ycnwODs8QDjnhyn3x/TzCcuzTaCB9p7OocD30Skz/6WiM55YxyQlM9ZxTlTk93b03q
         EIipNzik2hgvH7vZB9ee1PuacMq8V1vcgJUraYA0+UsbCK4YosxV89wnUgTzZw7n4+
         whc1yLFBg69MYsg1UqPWXwKg7wkk3j9YOXm3WM1Oi/xMn/tsdwKAo/ZsKWzOyqwl7l
         L7kSy86A0vjxw==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01071902.me.com (Postfix) with ESMTPSA id E6E475EC02A0;
        Wed,  4 Oct 2023 21:50:36 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Yeah Yeah <yeah32857@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: RE: [PATCH] iio: buffer: Fix demux update
Message-Id: <2CF81190-6E2E-4407-B49B-630140F08364@icloud.com>
Date:   Wed, 4 Oct 2023 17:50:31 -0400
Cc:     Jonathan.Cameron@huawei.com, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, pmeerw@pmeerw.net
To:     nuno.sa@analog.com
X-Mailer: iPhone Mail (18F72)
X-Proofpoint-GUID: Tb6RU7w7dP-yGMmSnmNSkGXWdsSCauN4
X-Proofpoint-ORIG-GUID: Tb6RU7w7dP-yGMmSnmNSkGXWdsSCauN4
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-11=5F01:2022-01-11=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=1 adultscore=0 bulkscore=0 mlxscore=1
 spamscore=1 mlxlogscore=187 clxscore=1015 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2310040161
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

=EF=BB=BF

Sent from my iPhone=
