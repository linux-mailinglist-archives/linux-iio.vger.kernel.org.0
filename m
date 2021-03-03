Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2956C32C6CE
	for <lists+linux-iio@lfdr.de>; Thu,  4 Mar 2021 02:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345989AbhCDAaG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Mar 2021 19:30:06 -0500
Received: from smtp2.macqel.be ([109.135.2.61]:12332 "EHLO smtp2.macqel.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231915AbhCCPzf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Mar 2021 10:55:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp2.macqel.be (Postfix) with ESMTP id E2E8F130D36
        for <linux-iio@vger.kernel.org>; Wed,  3 Mar 2021 16:31:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at macqel.be
Received: from smtp2.macqel.be ([127.0.0.1])
        by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NDOR0T-4xaNh for <linux-iio@vger.kernel.org>;
        Wed,  3 Mar 2021 16:31:46 +0100 (CET)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
        by smtp2.macqel.be (Postfix) with ESMTP id 15465130CB5
        for <linux-iio@vger.kernel.org>; Wed,  3 Mar 2021 16:31:46 +0100 (CET)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id EE3F0DF009D; Wed,  3 Mar 2021 16:31:45 +0100 (CET)
Date:   Wed, 3 Mar 2021 16:31:45 +0100
From:   Philippe De Muyter <phdm@macq.eu>
To:     linux-iio@vger.kernel.org
Subject: invensense mpu9250 ak8963 and devicetree
Message-ID: <20210303153145.GA30260@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

I am trying to use a mpu9250 imu, but I have trouble with the ak8963 part.

Currently, ak8975_probe fails in this code :

        /* Fetch the regulators */
        data->vdd = devm_regulator_get(&client->dev, "vdd");
        if (IS_ERR(data->vdd))
                return PTR_ERR(data->vdd);
        data->vid = devm_regulator_get(&client->dev, "vid");
        if (IS_ERR(data->vid))
                return PTR_ERR(data->vid);

but Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
says :

  vdd-supply:
    description: |
      an optional regulator that needs to be on to provide VDD power to
      the sensor.

I have no vdd or vdd-supply property in my ak8963 description.

Is that unrelated ?

What should I write in my dts file for this ak8963 embedded in a mpu9250 ?

Thanks in advance

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
