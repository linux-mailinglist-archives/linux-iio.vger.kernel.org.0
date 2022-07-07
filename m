Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43E9569D73
	for <lists+linux-iio@lfdr.de>; Thu,  7 Jul 2022 10:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiGGIap convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 7 Jul 2022 04:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiGGIap (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Jul 2022 04:30:45 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19584D4D4
        for <linux-iio@vger.kernel.org>; Thu,  7 Jul 2022 01:30:41 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26778Utv003271;
        Thu, 7 Jul 2022 04:30:33 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h5tu80fm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 04:30:33 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2678UWaC029556
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jul 2022 04:30:32 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 7 Jul 2022
 04:30:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 7 Jul 2022 04:30:31 -0400
Received: from euswvd-wpr-708.reddog.microsoft.com ([10.140.226.204])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2678SG4W015147;
        Thu, 7 Jul 2022 04:28:18 -0400
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <andy.shevchenko@gmail.com>
CC:     <Ibrahim.Tilki@analog.com>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: add max11410 adc driver
Date:   Thu, 7 Jul 2022 08:28:11 +0000
Message-ID: <20220707082811.167-1-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHp75Vc93yhKL+6FwfgvrV7QpDvP3OZt2LLZvSQcgO5PkYcaJg@mail.gmail.com>
References: <CAHp75Vc93yhKL+6FwfgvrV7QpDvP3OZt2LLZvSQcgO5PkYcaJg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: bv4UWZQ6XfLqDTbT5-vj8PqQ2MCkP4Au
X-Proofpoint-ORIG-GUID: bv4UWZQ6XfLqDTbT5-vj8PqQ2MCkP4Au
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_06,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1011 phishscore=0 malwarescore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070032
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> > +static irqreturn_t max11410_trigger_handler(int irq, void *p)
> > +{
> > +       struct iio_poll_func *pf = p;
> > +       struct iio_dev *indio_dev = pf->indio_dev;
> > +       struct max11410_state *st = iio_priv(indio_dev);
> > +       struct {
> > +               int data;
> > +               s64 ts __aligned(8);
> > +       } scan = {0};
> 
> Why do you need an assignment here?
> Even memcpy() in IRQ context is a burden.

Because the buffer gets populated with meaningless data in the absence of assignment due to timestamp alignment.
I've removed the assignment and addressed your other comments and sent a new series of patches.

Best regards,
Ibrahim Tilki
