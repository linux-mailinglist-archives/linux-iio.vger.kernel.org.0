Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5A82DF922
	for <lists+linux-iio@lfdr.de>; Mon, 21 Dec 2020 07:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgLUGHW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Dec 2020 01:07:22 -0500
Received: from msg-1.mailo.com ([213.182.54.11]:48318 "EHLO msg-1.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbgLUGHW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Dec 2020 01:07:22 -0500
X-Greylist: delayed 1276 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Dec 2020 01:07:21 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1608529524; bh=7bX6+glsjrsGlqe2AeGI/S1gq9LndgXNdvqBQa9fbi0=;
        h=X-EA-Auth:From:To:Date:Subject:MIME-Version:X-Mailer:Message-ID:
         Content-Type:Content-Transfer-Encoding;
        b=RryteprJkkEU1YE3ylwwPCMxfqJ3Od5Cj1p9mLCYaldxAXhuAOhYPePyEu2OJetqv
         8of9GW3Gm/rplAkFAlohEu5/Lfv/n5jQqtSFo8w9Rark3kaFggeETwuPwXFsVpxhzZ
         PyUjag74wa2beVDLybSJHwmS2xkXM6iDxyI9w1E0=
Received: by www-1.mailo.com with http webmail; Mon, 21 Dec 2020
  06:45:23 +0100 (CET)
X-EA-Auth: IflJqNmAoa6k3//PCLIxKmNcqpSuzWu9Cn9q1J38vPpzsY3CW5RQU2jMHTy/QT53pOa8BCT39wmgi7r1dN0MOwgLNQDtFefi
From:   yarl-baudig@mailoo.org
To:     linux-iio@vger.kernel.org
Date:   Mon, 21 Dec 2020 06:45:23 +0100 (CET)
Subject: device tree binding for iio-trig-hrtimer
X-Priority: 3
MIME-Version: 1.0
X-Mailer: COMS/EA20.04/r20201209
Message-ID: <ea-mime-5fe03673-6635-5dbe1461@www-1.mailo.com>
Content-Type: text/plain;
 charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=20

Is it possible to create and bind an iio-trig-hrtimer as an interrupt-pare=
nt (or something like that) for a sensor?
If so, what would the dts look like?

Thank you.



