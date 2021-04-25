Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7495336A867
	for <lists+linux-iio@lfdr.de>; Sun, 25 Apr 2021 18:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhDYQeM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Apr 2021 12:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230359AbhDYQeL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Apr 2021 12:34:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D94D61220;
        Sun, 25 Apr 2021 16:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619368412;
        bh=7ulvZw7FoVtlF5MLF312vy35wymDDd1C1msBUl5+1Uc=;
        h=From:To:Cc:Subject:Date:From;
        b=GuaiZ9snyLX/RNB0bQKi7Ts27HyqbFVe+n/k5lCMqp+soZc1j0ytxk7TXWzDEjUOY
         eqyaOrfCwr+XVelfSOzZWqHa3A52Rq0udvCBc4+VlsrQgbS5YZJbItFUxhoHse0j4+
         wtnu3jtas/zg1Y8QhvytwT5KXMcQIfhVy42CyiEYEXDqAAFpTSF0WZTGgxokak18rB
         +sS437fvQFfgokfJczrToYZEoAxZaAryc87MAHE2hJ7sDq9wg55vSgdTAIadod1Dud
         0+4DXWuWMdRPKj8m/bhlVktvWSkfBM7Hr1FecGsf95EIw6k4GBXGVzfjbvfLn7dmg7
         bLcAcRWHz3DyQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 0/2] iio:adc:ad7476: Regulator support and binding doc
Date:   Sun, 25 Apr 2021 17:31:52 +0100
Message-Id: <20210425163154.73209-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This driver supports a whole load of devices with a range of different
power supply connections.

Lars-Peter Clausen pointed out v1 did not handle the the ad7091r which
an internal voltage reference, but that can be over-driven on the vref_in /
vref_out pin.  The v2 handles that device properly.  I also realized that
I'd the binding was more restrictive for devices with internal references
than it needed to be (required vcc-supply) so I've relaxed that in
the updated bindings.  Also reorganized the big allOf block in the
binding doc to put all the constraints on reference voltage first.

v3 incorporates Lars' suggestion to set the regulator pointer to null
as a way to indicate that we should definitely use the internal reference.

v4 fixes case of errors on the devm_regulator_get_optional() that are about
something different than -ENODEV which signifies the regulator isn't
specified.

Jonathan Cameron (2):
  iio:adc:ad7476: Handle the different regulators used by various parts.
  dt-bindings:iio:adc:adi,ad7476: Add missing binding document

 .../bindings/iio/adc/adi,ad7476.yaml          | 174 ++++++++++++++++++
 drivers/iio/adc/ad7476.c                      | 118 ++++++++++--
 2 files changed, 277 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml

-- 
2.31.1

