Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCA2351994
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhDARyK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 13:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236424AbhDARs0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 13:48:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6866461283;
        Thu,  1 Apr 2021 14:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617286311;
        bh=672rw3lgTObpdwq9464u1QdOhqK0HXUeLiYqi8w+Rfc=;
        h=From:To:Cc:Subject:Date:From;
        b=lt1nZFtyvgqMgAYcfSb2sLMPEXBi7xFtg+9MpYQ1DQp2Jx08a4JKNYQ96MizXwyus
         HQPdN5tT1k89ZxkCfoZPTkzdL+Q5SH2segVcgnABV9BgjVXk7NDKcoPnzegQZntYW4
         hLDbuzm1hJmKR8o9z4v5aYuxa5W5Ef71lpJaJQEQ4g3Ksfmy/EHRsV9o8RvWZ92pLy
         pveTePXfG+jgqr5EBGkV8c+ssCPRSwpP2Gz+eLR4nO8ndOQ687tsclGgQ/G3Y4tO62
         5eGQQuviaBq2JFWwK58Wz67suWmK2yALN+3o9a2Lg0rXNujZ1xtAz/4LfsWxYnrHPT
         jQUDan6u6RYQw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/2] dt-bindings:iio:yaml conversions with xor condition
Date:   Thu,  1 Apr 2021 15:09:54 +0100
Message-Id: <20210401140956.224084-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These two binding conversions are left from last year because I couldn't
figure out how to do the XOR between spi-cpha and spi-cpol without
using a $ref.  Rob suggested it should work by lifting the $ref block
and putting it inline but that ran into a restriction the dt-schema that
a oneOf is not allowed directly under an allOf.

Line 34 of schema/base.yaml
  allOf:
    items:
      propertyNames:
        enum:
          - $ref
          - if
          - then
          - else
  anyOf: true

I was just about to send a pull request to relax that constraint when I
realized that a top level oneOf was sufficient for this XoR condition
because it rules out more than one of the options being true at the same
time.  Hence the simplified version given here constrains things correctly.

oneOf:
  - required:
      - spi-cpha
  - required:
      - spi-cpol

We don't need to also specify
not:
  required: [spi-cpha, spi-cpol]
as done in earlier versions of these bindings.

One other minor change in patch 2 to make Should -> Must to avoid
confusion.

Jonathan Cameron (2):
  dt-bindings:iio:dac:ad5755: txt to yaml format conversion.
  dt-bindings:iio:dac:ti,dac082s085 yaml conversion

 .../devicetree/bindings/iio/dac/ad5755.txt    | 124 -------------
 .../bindings/iio/dac/adi,ad5755.yaml          | 171 ++++++++++++++++++
 .../bindings/iio/dac/ti,dac082s085.yaml       |  72 ++++++++
 .../bindings/iio/dac/ti-dac082s085.txt        |  34 ----
 4 files changed, 243 insertions(+), 158 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ad5755.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt

-- 
2.31.1

