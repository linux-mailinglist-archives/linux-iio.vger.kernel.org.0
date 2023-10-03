Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1A57B5EA6
	for <lists+linux-iio@lfdr.de>; Tue,  3 Oct 2023 03:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbjJCBXp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Oct 2023 21:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbjJCBXp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Oct 2023 21:23:45 -0400
X-Greylist: delayed 313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 Oct 2023 18:23:42 PDT
Received: from qs51p00im-qukt01080501.me.com (qs51p00im-qukt01080501.me.com [17.57.155.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978E1BF
        for <linux-iio@vger.kernel.org>; Mon,  2 Oct 2023 18:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1696295908;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=lFtKS1t86/ViV23mEIeRrkVd7xdx8Ik46l3dxhnTJISOSsjz6npVh2yHZ9YPTJ1q+
         yGu6qEiXx/RZHFNjPBUk+XP7OACkBrtINKjbz7HXgCoVnoQrtvdyPjcYIxlRUaZ/94
         bQ1SpF/LiqyA2FBbdqxzxHaGYd+2SYjC8hBoln0WTkDEepI98DNZgRrVvO+77M6+v0
         sLY/SQqJyducHMkTzwT437o3sVQDOkGU+qpJOJtviZDnMmsthzasxhsPL77cY9wtgf
         d2CzFvzwXF1Yt5HNBcXEUxh+p+T+E1jg0f47AMd8gUkAopznFb8TYGWZk7AK52G2OT
         rNpmdsFp4157Q==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01080501.me.com (Postfix) with ESMTPSA id DF4241980242;
        Tue,  3 Oct 2023 01:18:26 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Yeah Yeah <yeah32857@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Mon, 2 Oct 2023 21:18:23 -0400
Subject: RE: [PATCH] iio: buffer: Fix demux update
Message-Id: <029935E4-CC3A-4899-8D45-653CFB440B03@icloud.com>
Cc:     Jonathan.Cameron@huawei.com, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, pmeerw@pmeerw.net
To:     nuno.sa@analog.com
X-Mailer: iPhone Mail (18F72)
X-Proofpoint-GUID: XQ3L32uFCdFdNHB2H8_gQsYurksUZQZ8
X-Proofpoint-ORIG-GUID: XQ3L32uFCdFdNHB2H8_gQsYurksUZQZ8
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=5 mlxlogscore=129 suspectscore=0
 adultscore=0 bulkscore=0 clxscore=1011 malwarescore=0 mlxscore=5
 phishscore=0 spamscore=5 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2310030009
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


