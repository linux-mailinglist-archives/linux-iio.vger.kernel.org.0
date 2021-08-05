Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A443E0D65
	for <lists+linux-iio@lfdr.de>; Thu,  5 Aug 2021 06:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhHEEw3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Aug 2021 00:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230337AbhHEEw3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Aug 2021 00:52:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 78F2960F22
        for <linux-iio@vger.kernel.org>; Thu,  5 Aug 2021 04:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628139134;
        bh=0GV/KuvFzTBBplmd+pGecx3oiAgR4gr1m/w1UJ92iHE=;
        h=From:To:Subject:Date:From;
        b=MmBvnt8AkZWJldw6vkAf4VwyJexSQM/DKJmZCR9g98d7tPEQmkqOJKALlLzqP/kyD
         86QEBL9O/WTUAipAJcbgGe+8Fa7WPl1RA1wnXTqsZ3NWRSBDSYjdyw41BU/p+qTIHE
         eChnqYlD5PiNZaAq6+f/+Q7fxh9VW7d46XHAJVR/cuvHU6YCQK+F35Fts98lZ2hXcj
         8AvTk7tfdelCX/pDHKwSiKPD4B2+m5MlsGz5rFlcBbvaD0rEetjRD/1TWQk4ksjiEI
         40FlKmnmhWP1h9lDcmzvUEaRvA6ELXL9VPCFTpP7PFb3NlNlplcTGD5KklRmBqU2nx
         RiAdiU6RHaTtA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 665FE60F36; Thu,  5 Aug 2021 04:52:14 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-iio@vger.kernel.org
Subject: [Bug 213979] New: needs unknown symbol errors building
 cros_ec_sensors_core
Date:   Thu, 05 Aug 2021 04:52:14 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jason@montleon.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-213979-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213979

            Bug ID: 213979
           Summary: needs unknown symbol errors building
                    cros_ec_sensors_core
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.13.6
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IIO
          Assignee: drivers_iio@kernel-bugs.kernel.org
          Reporter: jason@montleon.com
        Regression: No

Created attachment 298213
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D298213&action=3Dedit
config

depmod: WARNING:
/home/jason/rpmbuild/BUILDROOT/kernel-5.13.6-200.fc34.x86_64/./lib/modules/=
5.13.6-200.fc34.x86_64+debug/kernel/drivers/iio/common/cros_ec_sensors/cros=
_ec_sensors_core.ko
needs unknown symbol cros_ec_sensorhub_register_push_data

depmod: WARNING:
/home/jason/rpmbuild/BUILDROOT/kernel-5.13.6-200.fc34.x86_64/./lib/modules/=
5.13.6-200.fc34.x86_64+debug/kernel/drivers/iio/common/cros_ec_sensors/cros=
_ec_sensors_core.ko
needs unknown symbol cros_ec_sensorhub_unregister_push_data

I've attached the config. Please let me know if there is anything else I can
provide.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
