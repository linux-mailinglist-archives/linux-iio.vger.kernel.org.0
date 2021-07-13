Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C783C6DC8
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 11:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbhGMJ4a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 05:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbhGMJ4a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 05:56:30 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE948C0613DD;
        Tue, 13 Jul 2021 02:53:40 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 21so19083133pfp.3;
        Tue, 13 Jul 2021 02:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WsaJEEtXLdNnSdFh/wKlIqx0fCbuUEm2v5+ZJtQjif8=;
        b=NkTsno1gYSLaJl62s8QMpXbOEHgIb175G4xJrhiZXoqhCqsG1EIOgS1bTswQITbGTi
         5OfEUHNZGhTOTJ23LwtDf1L4JfSfIUxdlorljNszdVIeEFPYB2Wry7RqSZYFHs/PEDW3
         TwzLIzRbQ5BoB0SkAI8uFB7oaVUWv52IkwOg+e+E3xF3MN4P9xoCpwyTzcJwo6QjB5I9
         XUIwS9EaKx+BBYmmRRKLkWl5+FdT+KswIy5ToBxr6wYuX3NmbsZFPUndXxXRu/cEyhVC
         cG8pujM8EPBv3IS1piUFpTg9rvWuYxfltVwSqD8TJge+DcHPa6j4cqpZqg2WRLlPq+Nx
         H8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WsaJEEtXLdNnSdFh/wKlIqx0fCbuUEm2v5+ZJtQjif8=;
        b=CcqJrie3/FBzn2YCW89WxLrQaN5sue+/QQJIb3YnRZzQVWgG0nVFBQclBj8SyYkUHD
         jQp8gyXr10ZQYTfNVdMW/+fWrYpUWBR22CVA972Ma+SfFBdUrOwGuLRFBqcJjtAhvy99
         tKGDU1Z4FFKgOR8NMMDBu9JffBlv7FEaOqoaI/ZcHpW7sd+PdCvqtnXViRozfpTK25a8
         5nOFXuyETRCTsZviqFWX2c8mKRrqOOgNmkRiJT8uXHOsly3O/+tRVtxQDXTSVj82KROD
         hsiAsb7ecUhJuky+87Nt+00fhX4FqeReV3cyTzUMW8h6456mVEUGGgGEVQbeWCN2Gz0E
         KDfg==
X-Gm-Message-State: AOAM532kYaDb2ciGIbVCxe9PHkvr2MUFzE+z65zAe4vImh+TXE70PJKr
        0sF+nCcYthnyQDfK0XqKJxU=
X-Google-Smtp-Source: ABdhPJwoMmi75N66tKuoy7eviFH44flakEZxvMYXuLDuUZ60Zq2yZ3hF/8jGKH68X8xMVwCFowEyEg==
X-Received: by 2002:a05:6a00:1692:b029:300:7193:f67 with SMTP id k18-20020a056a001692b029030071930f67mr3831184pfc.19.1626170020123;
        Tue, 13 Jul 2021 02:53:40 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id f6sm18153854pfj.28.2021.07.13.02.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 02:53:39 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v13 00/17] Introduce the Counter character device interface
Date:   Tue, 13 Jul 2021 18:53:04 +0900
Message-Id: <cover.1626165764.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes in v13:
 - Use GFP_KERNEL when using mutexes instead of spinlocks
 - Free event_node on error in counter_set_event_node
 - Create n_events_list_lock mutex for protecting next_events_list
   access
 - Adjust counter_set_event_node() locking to cover watch_validate() too
 - Pull out COUNTER_ENABLE_EVENTS_IOCTL code into its own function
   counter_enable_events()
 - Reimplement chrdev_lock as a bitmap and utilize
   test_and_set_bit_lock()/clear_bit_unlock() to handle locking
 - Move wake_up_poll() call to after spin_unlock_irqrestore() in the
   counter_push_event() function
 - Drop the lock on error in counter_events_queue_size_write()
 - Rename "group" to "cattr_group" where appropriate for clarity
 - Pull allocation of attribute groups to outside of for-loop in
   counter_sysfs_add()
 - Define and use enum translation function st32_lptim_func_map()
 - Provide complete example in enum counter_component documentation
 - Provide inline description comments for enum counter_event_type
 - Move documentation of Counter ioctl commands inline with code and
   reference them using :c:macro: in generic-counter.rst
 - Make it clear which callbacks are optional in struct counter_ops
 - Use HTML tables in Documentation/driver-api/generic-counter.rst
 - Qualify struct counter_watch watches as statin in counter_example.c
 - Return 1 on read() error in counter_example.c
 - Remove unnecessary explicit casts in counter_example.c

For convenience, this patchset is also available on my personal git
repo: https://gitlab.com/vilhelmgray/iio/-/tree/counter_chrdev_v13

The patches preceding "counter: Internalize sysfs interface code" are
primarily cleanup and fixes that can be picked up and applied now to the
IIO tree if so desired. The "counter: Internalize sysfs interface code"
patch as well may be considered for pickup because it is relatively safe
and makes no changes to the userspace interface.

To summarize the main points of this patchset: there are no changes to
the existing Counter sysfs userspace interface; a Counter character
device interface is introduced that allows Counter events and associated
data to be read() by userspace; the events_configure() and
watch_validate() driver callbacks are introduced to support Counter
events; and IRQ support is added to the 104-QUAD-8 driver, serving as an
example of how to support the new Counter events functionality.

I did discover an issue with the character device code that I'm having
trouble understanding. The issue does not affect the sysfs interface
code so it's still safe to merge up to patch 08/17; only the character
device node is affected starting with patch 10/17.

Suppose I open the chrdev from a userspace application and keep it open,
but then remove the respective driver and Counter subsystem module from
my system. The devm_counter_release() and counter_exit() functions will
be called as expected; the counter_chrdev_release() function will not be
called yet, but that is expected because the chrdev is still open by
userspace. If I try to break out of my userspace application, I expect
counter_chrdev_release() to finally be called, but this does not happen.
Instead, my userspace application stalls and I see the following error
in my dmesg:

[  172.859570] BUG: unable to handle page fault for address: ffffffffc09ae298
[  172.859594] #PF: supervisor read access in kernel mode
[  172.859598] #PF: error_code(0x0000) - not-present page
[  172.859603] PGD 23615067 P4D 23615067 PUD 23617067 PMD 1029ad067 PTE 0
[  172.859623] Oops: 0000 [#1] SMP NOPTI
[  172.859629] CPU: 2 PID: 2485 Comm: counter_example Not tainted 5.13.0+ #1
[  172.859640] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS d55cb5a 04/01/2014
[  172.859645] RIP: 0010:filp_close+0x29/0x70
[  172.859662] Code: 90 0f 1f 44 00 00 55 48 89 e5 41 56 41 55 41 54 48 8b 47 38 48 85 c0 0f 84 b7 40 86 00 48 8b 47 28 49 89 fc 49 89 f5 45 31 f6 <48> 8b 40 78 48 85 c0 74 08 ff d0 0f 1f 00 41 89 c6 41 f6 44 24 45
[  172.859669] RSP: 0018:ffffad31c0ee7cb0 EFLAGS: 00010246
[  172.859675] RAX: ffffffffc09ae220 RBX: 0000000000000001 RCX: 0000000000000001
[  172.859680] RDX: ffff9a43829708e0 RSI: ffff9a4382970840 RDI: ffff9a43821f4f00
[  172.859684] RBP: ffffad31c0ee7cc8 R08: 0000000000000001 R09: 0000000000000001
[  172.859687] R10: ffffffffffff4d00 R11: ffff9a43933c6e10 R12: ffff9a43821f4f00
[  172.859691] R13: ffff9a4382970840 R14: 0000000000000000 R15: 0000000000000003
[  172.859694] FS:  0000000000000000(0000) GS:ffff9a44b7d00000(0000) knlGS:0000000000000000
[  172.859699] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  172.859704] CR2: ffffffffc09ae298 CR3: 0000000023610001 CR4: 0000000000370ee0
[  172.859713] Call Trace:
[  172.859730]  put_files_struct+0x73/0xd0
[  172.859738]  exit_files+0x49/0x50
[  172.859743]  do_exit+0x33b/0xa20
[  172.859751]  do_group_exit+0x3b/0xb0
[  172.859758]  get_signal+0x16f/0x8b0
[  172.859766]  ? _copy_to_user+0x20/0x30
[  172.859774]  ? put_timespec64+0x3d/0x60
[  172.859784]  arch_do_signal_or_restart+0xf3/0x850
[  172.859794]  ? hrtimer_nanosleep+0x9f/0x120
[  172.859802]  ? __hrtimer_init+0xd0/0xd0
[  172.859808]  exit_to_user_mode_prepare+0x122/0x1b0
[  172.859816]  syscall_exit_to_user_mode+0x27/0x50
[  172.859825]  do_syscall_64+0x48/0xc0
[  172.859831]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  172.859839] RIP: 0033:0x7f07f8b9951a
[  172.859850] Code: Unable to access opcode bytes at RIP 0x7f07f8b994f0.
[  172.859853] RSP: 002b:00007ffc0d12c230 EFLAGS: 00000246 ORIG_RAX: 00000000000000e6
[  172.859860] RAX: fffffffffffffdfc RBX: ffffffffffffff01 RCX: 00007f07f8b9951a
[  172.859863] RDX: 00007ffc0d12c2b0 RSI: 0000000000000000 RDI: 0000000000000000
[  172.859867] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffc0d12c1c6
[  172.859871] R10: 00007ffc0d12c2b0 R11: 0000000000000246 R12: 00007ffc0d12c2b0
[  172.859874] R13: 00007ffc0d12c2b0 R14: 0000000000000000 R15: 0000000000000000
[  172.859886] Modules linked in: intel_rapl_msr intel_rapl_common kvm_intel kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel nls_iso8859_1 aesni_intel crypto_simd cryptd rapl drm_ttm_helper ttm uvcvideo drm_kms_helper videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common input_leds syscopyarea videodev sysfillrect sysimgblt fb_sys_fops cec rc_core joydev mc drm serio_raw mac_hid qemu_fw_cfg sch_fq_codel msr parport_pc ppdev lp parport virtio_rng ip_tables x_tables autofs4 hid_generic usbhid hid virtio_net psmouse net_failover i2c_piix4 virtio_blk failover pata_acpi floppy [last unloaded: counter]
[  172.859995] CR2: ffffffffc09ae298
[  172.860009] ---[ end trace e7d3d7da1a73b8f4 ]---
[  172.860013] RIP: 0010:filp_close+0x29/0x70
[  172.860021] Code: 90 0f 1f 44 00 00 55 48 89 e5 41 56 41 55 41 54 48 8b 47 38 48 85 c0 0f 84 b7 40 86 00 48 8b 47 28 49 89 fc 49 89 f5 45 31 f6 <48> 8b 40 78 48 85 c0 74 08 ff d0 0f 1f 00 41 89 c6 41 f6 44 24 45
[  172.860027] RSP: 0018:ffffad31c0ee7cb0 EFLAGS: 00010246
[  172.860031] RAX: ffffffffc09ae220 RBX: 0000000000000001 RCX: 0000000000000001
[  172.860034] RDX: ffff9a43829708e0 RSI: ffff9a4382970840 RDI: ffff9a43821f4f00
[  172.860038] RBP: ffffad31c0ee7cc8 R08: 0000000000000001 R09: 0000000000000001
[  172.860041] R10: ffffffffffff4d00 R11: ffff9a43933c6e10 R12: ffff9a43821f4f00
[  172.860044] R13: ffff9a4382970840 R14: 0000000000000000 R15: 0000000000000003
[  172.860047] FS:  0000000000000000(0000) GS:ffff9a44b7d00000(0000) knlGS:0000000000000000
[  172.860052] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  172.860056] CR2: ffffffffc09ae298 CR3: 0000000023610001 CR4: 0000000000370ee0
[  172.860073] Fixing recursive fault but reboot is needed!

It looks like faults in filp_close() before counter_chrdev_release() is
called. Is this issue manifesting because counter_exit() was called
earlier while the chrdev was still open?

William Breathitt Gray (17):
  counter: 104-quad-8: Return error when invalid mode during
    ceiling_write
  counter: Return error code on invalid modes
  counter: Standardize to ERANGE for limit exceeded errors
  counter: Rename counter_signal_value to counter_signal_level
  counter: Rename counter_count_function to counter_function
  counter: Internalize sysfs interface code
  counter: Update counter.h comments to reflect sysfs internalization
  docs: counter: Update to reflect sysfs internalization
  counter: Move counter enums to uapi header
  counter: Add character device interface
  docs: counter: Document character device interface
  tools/counter: Create Counter tools
  counter: Implement signalZ_action_component_id sysfs attribute
  counter: Implement *_component_id sysfs attributes
  counter: Implement events_queue_size sysfs attribute
  counter: 104-quad-8: Replace mutex with spinlock
  counter: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8

 Documentation/ABI/testing/sysfs-bus-counter   |   38 +-
 Documentation/driver-api/generic-counter.rst  |  358 +++-
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 MAINTAINERS                                   |    3 +-
 drivers/counter/104-quad-8.c                  |  728 ++++----
 drivers/counter/Kconfig                       |    6 +-
 drivers/counter/Makefile                      |    1 +
 drivers/counter/counter-chrdev.c              |  514 ++++++
 drivers/counter/counter-chrdev.h              |   14 +
 drivers/counter/counter-core.c                |  182 ++
 drivers/counter/counter-sysfs.c               |  962 +++++++++++
 drivers/counter/counter-sysfs.h               |   13 +
 drivers/counter/counter.c                     | 1496 -----------------
 drivers/counter/ftm-quaddec.c                 |   59 +-
 drivers/counter/intel-qep.c                   |  150 +-
 drivers/counter/interrupt-cnt.c               |   73 +-
 drivers/counter/microchip-tcb-capture.c       |  103 +-
 drivers/counter/stm32-lptimer-cnt.c           |  211 ++-
 drivers/counter/stm32-timer-cnt.c             |  147 +-
 drivers/counter/ti-eqep.c                     |  205 ++-
 include/linux/counter.h                       |  717 ++++----
 include/linux/counter_enum.h                  |   45 -
 include/uapi/linux/counter.h                  |  154 ++
 tools/Makefile                                |   13 +-
 tools/counter/Build                           |    1 +
 tools/counter/Makefile                        |   53 +
 tools/counter/counter_example.c               |   93 +
 27 files changed, 3572 insertions(+), 2768 deletions(-)
 create mode 100644 drivers/counter/counter-chrdev.c
 create mode 100644 drivers/counter/counter-chrdev.h
 create mode 100644 drivers/counter/counter-core.c
 create mode 100644 drivers/counter/counter-sysfs.c
 create mode 100644 drivers/counter/counter-sysfs.h
 delete mode 100644 drivers/counter/counter.c
 delete mode 100644 include/linux/counter_enum.h
 create mode 100644 include/uapi/linux/counter.h
 create mode 100644 tools/counter/Build
 create mode 100644 tools/counter/Makefile
 create mode 100644 tools/counter/counter_example.c


base-commit: 50be9417e23af5a8ac860d998e1e3f06b8fd79d7
-- 
2.32.0

